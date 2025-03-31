Return-Path: <linux-iio+bounces-17416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C01A76471
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8C91885E92
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0693E1DF738;
	Mon, 31 Mar 2025 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpgrFv7/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D491D514E;
	Mon, 31 Mar 2025 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743417636; cv=none; b=WhmpZqw4QCjNgWox5a+F0kpylUGqd3Mzi5zmFgwg5U6u1GA3GY1j/d7/trxaz7ojEuHpXuC5rf/nojVmSgqZZ5Ov7/nd7hkSYRgCkkX1/eIYQC5nPsebFbArk9CpwlO30xhpfEfM57Wip7cUqhd5RE3J0j15uPpR94WvJ+lYJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743417636; c=relaxed/simple;
	bh=xNHvghKTAooo5rUet2CY72pCirZRWaZON5GFTGGSXn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kS5EtBoILvCzGzKQJ/L4olY0xbFEvywgHwOOjBMqId8MG5vo7hoIEtIPsCpF/kYsULcYE+81NaW2p+FUJn7kYeoiraXUSxPvzhDSpzmJIZrUhn/DUuyit3Kt2CTxf/PZ7+WvfmFKcAzGLa59FPRFamK/uLPaDy0vOXD8upQw9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpgrFv7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841BAC4CEE3;
	Mon, 31 Mar 2025 10:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743417636;
	bh=xNHvghKTAooo5rUet2CY72pCirZRWaZON5GFTGGSXn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bpgrFv7/XH6Y2DdGNw/jrtUgbqUcrPo/VpBGiCAx2Td12l45EXOifI1O7FvgvKvsy
	 mLYJTGz2T2EAMG9x44+7BrlcXDdiU2CTsiz04aIthXkJJl29Chyh+ilA3bqeGWwAlw
	 I5N7jm8QIQcmL+oTdTcl3waCUsN/W4Xv3JPs8vvtLMAOPVT1rqW6wZZjn9BnxK01oJ
	 8HgU1Z0wvmsv+Mn8fo5dv2UvCXCuHD0pn1vmX/4l8bzNolxnh2afBMbzQFE5CUIdXP
	 oE6pRDIsQcOMlMDxIQ4WCFm8S0t/umA3J7ILq1UpludgdcpKfMQRxJg2oQzv2s23g3
	 2muOKQk71l23Q==
Date: Mon, 31 Mar 2025 11:40:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 08/11] iio: accel: adxl345: add activity event
 feature
Message-ID: <20250331114029.2d828b19@jic23-huawei>
In-Reply-To: <20250318230843.76068-9-l.rubusch@gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
	<20250318230843.76068-9-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 23:08:40 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Make the sensor detect and issue interrupts at activity. Activity
> events are configured by a threshold stored in regmap cache. Initialize
> the activity threshold register to a reasonable default value in probe.
> The value is taken from the older ADXL345 input driver, to provide a
> similar behavior. Reset the activity/inactivity direction enabling
> register in probe. Reset and initialization shall bring the sensor in a
> defined initial state to prevent dangling settings when warm restarting
> the sensor.
> 
> Activity, ODR configuration together with the range setting prepare the
> activity/inactivity hystersesis setup, implemented in a follow up patch.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

> +static int adxl345_is_act_inact_en(struct adxl345_state *st,
> +				   enum iio_modifier axis,
> +				   enum adxl345_activity_type type, bool *en)
> +{
> +	unsigned int regval;
> +	bool axis_en;
> +	u32 axis_ctrl;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &axis_ctrl);
> +	if (ret)
> +		return ret;
> +
> +	if (type == ADXL345_ACTIVITY) {
> +		switch (axis) {
> +		case IIO_MOD_X:
> +			axis_en = FIELD_GET(ADXL345_ACT_X_EN, axis_ctrl);
> +			break;
> +		case IIO_MOD_Y:
> +			axis_en = FIELD_GET(ADXL345_ACT_Y_EN, axis_ctrl);
> +			break;
> +		case IIO_MOD_Z:
> +			axis_en = FIELD_GET(ADXL345_ACT_Z_EN, axis_ctrl);
Same as in earlier patch; axis_en is never used.
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
> +	if (ret)
> +		return ret;
> +
> +	*en = (adxl345_act_int_reg[type] & regval) > 0;
> +
> +	return 0;
> +}
> +
> +static int adxl345_set_act_inact_en(struct adxl345_state *st,
> +				    enum iio_modifier axis,
> +				    enum adxl345_activity_type type,
> +				    bool cmd_en)
> +{
> +	bool axis_en, en;
> +	unsigned int threshold;
> +	u32 axis_ctrl = 0;
> +	int ret;
> +
> +	if (type == ADXL345_ACTIVITY) {
> +		switch (axis) {
> +		case IIO_MOD_X:
> +			axis_ctrl = ADXL345_ACT_X_EN;
> +			break;
> +		case IIO_MOD_Y:
> +			axis_ctrl = ADXL345_ACT_Y_EN;
> +			break;
> +		case IIO_MOD_Z:
> +			axis_ctrl = ADXL345_ACT_Z_EN;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (cmd_en)
> +		ret = regmap_set_bits(st->regmap,
> +				      ADXL345_REG_ACT_INACT_CTRL, axis_ctrl);
> +	else
> +		ret = regmap_clear_bits(st->regmap,
> +					ADXL345_REG_ACT_INACT_CTRL, axis_ctrl);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, adxl345_act_thresh_reg[type], &threshold);
> +	if (ret)
> +		return ret;
> +
> +	en = false;
> +
> +	if (type == ADXL345_ACTIVITY) {
> +		axis_en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl) > 0;
The > 0 doesn't add anything as this can't be negative.

Drag declaration of axis_en down here as only used in this block.
or just combine with previous and next bit as
		en = (type === ADXL345_ACTIVITY) &&
		     FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl) &&
		     (threshold > 0);

> +		en = axis_en && threshold > 0;
> +	}
> +
> +	return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> +				  adxl345_act_int_reg[type],
> +				  en ? adxl345_act_int_reg[type] : 0);
> +}
> +
>  /* tap */
>  



> @@ -1347,6 +1542,14 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		if (ret)
>  			return ret;
>  
> +		ret = regmap_write(st->regmap, ADXL345_REG_ACT_INACT_CTRL, 0);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_ACT, 6);

6 is a fairly random number. Add a comment for why this default.

> +		if (ret)
> +			return ret;
> +
>  		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_TAP, tap_threshold);
>  		if (ret)
>  			return ret;


