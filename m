Return-Path: <linux-iio+bounces-16613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD79A58601
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE5E16A128
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48BB1DF73C;
	Sun,  9 Mar 2025 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3X8rm2J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6419D2AE95
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540035; cv=none; b=aQcrbyxkPIqAxMHzF29TLBsODZcd+XEIANnzaQ1VQBHMBjjyDwWryN022A5QKA5Z7z5zeLlRBMRcqy6wsthyrG0WGckTNCpKPfkQTku7Ix0ikVVj2/+Y5K6X1GuMKby95i1WqWHB1DLnLakeaAogj/8HcDi25WOCdClPYAJzlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540035; c=relaxed/simple;
	bh=J1peNvtbqg/4XCLOiloqFKaY9W27lzFvudSdHnLpPGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aw46/8KYVj7zGg8tPpzwhhvvA63AU6x6bq0RxQpPjNx3p070gWyXzZb51dU24HpCrTs2I5r2TcZeuFkPwdMAltJvbHqTfPEa0nC4eHYfcJGgUR/EQJx8crQ4HbLmhYlcQDe5etadKhvOhuS8B/yJjdAWww1+o02fPUo+CV5h/Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3X8rm2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C53C4CEE5;
	Sun,  9 Mar 2025 17:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540033;
	bh=J1peNvtbqg/4XCLOiloqFKaY9W27lzFvudSdHnLpPGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3X8rm2Js1k4GRlxLSx0aY/Jd57GuhFX2ZwTDGEphXq9vCtIgp+AsoZ/M6cuFZJgo
	 PgV7jNiLZRWq5jtUhmAXynemujb40ZBoZX/2JTEeYgsB9fze3CpvjFzqvIFqNlxNXn
	 RgAC0dMXlX90p6tA9xG4MYvQOkkgxKy+4htS3k+tjSu+0UOYdf+Fq1UApvqbSPseqL
	 yY749RE909l9S2ZpB7E7/6NApxs9CTehvxKoWhSfu3EHOfzeL1e3kw14p6sLStMCja
	 Ws+WIA85pTdk0JhzEuaJz10Hs3FmCb57QSI23u7Bcyhh5wqRkfpJyuo/UD0p6oFWxH
	 6lAWn+JcZ135Q==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 07/18] iio: light: ltr501: Factor out core of write_raw() where direct mode claim is held.
Date: Sun,  9 Mar 2025 17:06:22 +0000
Message-ID: <20250309170633.1347476-8-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309170633.1347476-1-jic23@kernel.org>
References: <20250309170633.1347476-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Factoring this code out allows for direct returns on error simplifying code
flow.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/ltr501.c | 94 +++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index b42df15b36e1..c44c852a7d76 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -763,18 +763,14 @@ static int ltr501_get_gain_index(const struct ltr501_gain *gain, int size,
 	return -1;
 }
 
-static int ltr501_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long mask)
+static int __ltr501_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
 {
 	struct ltr501_data *data = iio_priv(indio_dev);
 	int i, ret, freq_val, freq_val2;
 	const struct ltr501_chip_info *info = data->chip_info;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
@@ -782,53 +778,43 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 			i = ltr501_get_gain_index(info->als_gain,
 						  info->als_gain_tbl_size,
 						  val, val2);
-			if (i < 0) {
-				ret = -EINVAL;
-				break;
-			}
+			if (i < 0)
+				return -EINVAL;
 
 			data->als_contr &= ~info->als_gain_mask;
 			data->als_contr |= i << info->als_gain_shift;
 
-			ret = regmap_write(data->regmap, LTR501_ALS_CONTR,
-					   data->als_contr);
-			break;
+			return regmap_write(data->regmap, LTR501_ALS_CONTR,
+					    data->als_contr);
 		case IIO_PROXIMITY:
 			i = ltr501_get_gain_index(info->ps_gain,
 						  info->ps_gain_tbl_size,
 						  val, val2);
-			if (i < 0) {
-				ret = -EINVAL;
-				break;
-			}
+			if (i < 0)
+				return -EINVAL;
+
 			data->ps_contr &= ~LTR501_CONTR_PS_GAIN_MASK;
 			data->ps_contr |= i << LTR501_CONTR_PS_GAIN_SHIFT;
 
-			ret = regmap_write(data->regmap, LTR501_PS_CONTR,
-					   data->ps_contr);
-			break;
+			return regmap_write(data->regmap, LTR501_PS_CONTR,
+					    data->ps_contr);
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		break;
 
 	case IIO_CHAN_INFO_INT_TIME:
 		switch (chan->type) {
 		case IIO_INTENSITY:
-			if (val != 0) {
-				ret = -EINVAL;
-				break;
-			}
+			if (val != 0)
+				return -EINVAL;
+
 			mutex_lock(&data->lock_als);
 			ret = ltr501_set_it_time(data, val2);
 			mutex_unlock(&data->lock_als);
-			break;
+			return ret;
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		break;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		switch (chan->type) {
@@ -836,50 +822,62 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 			ret = ltr501_als_read_samp_freq(data, &freq_val,
 							&freq_val2);
 			if (ret < 0)
-				break;
+				return ret;
 
 			ret = ltr501_als_write_samp_freq(data, val, val2);
 			if (ret < 0)
-				break;
+				return ret;
 
 			/* update persistence count when changing frequency */
 			ret = ltr501_write_intr_prst(data, chan->type,
 						     0, data->als_period);
 
 			if (ret < 0)
-				ret = ltr501_als_write_samp_freq(data, freq_val,
-								 freq_val2);
-			break;
+				/* Do not ovewrite error */
+				ltr501_als_write_samp_freq(data, freq_val,
+							   freq_val2);
+			return ret;
 		case IIO_PROXIMITY:
 			ret = ltr501_ps_read_samp_freq(data, &freq_val,
 						       &freq_val2);
 			if (ret < 0)
-				break;
+				return ret;
 
 			ret = ltr501_ps_write_samp_freq(data, val, val2);
 			if (ret < 0)
-				break;
+				return ret;
 
 			/* update persistence count when changing frequency */
 			ret = ltr501_write_intr_prst(data, chan->type,
 						     0, data->ps_period);
 
 			if (ret < 0)
-				ret = ltr501_ps_write_samp_freq(data, freq_val,
-								freq_val2);
-			break;
+				/* Do not overwrite error */
+				ltr501_ps_write_samp_freq(data, freq_val,
+							  freq_val2);
+			return ret;
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		break;
-
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
+}
+
+static int ltr501_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = __ltr501_write_raw(indio_dev, chan, val, val2, mask);
 
 	iio_device_release_direct_mode(indio_dev);
+
 	return ret;
 }
 
-- 
2.48.1


