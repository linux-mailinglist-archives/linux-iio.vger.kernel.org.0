Return-Path: <linux-iio+bounces-15684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637EAA38637
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772E23B6755
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DB2225391;
	Mon, 17 Feb 2025 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6JMYIXK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80822332C
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801876; cv=none; b=cknzLYskOBeBZtV+8kJv8Up/t+14ZSOss2QXUa8v4pS3Cg8JVVzgi97tMQ6VpDaeNMZ55ckvc+0I1liZRsFXy6zXC9hKQ4nor8Z/p+j+GD/FgHmxP0PBJaFRdSgVi6JwsnmyuW7qNG/1JoRwbrq40YqGqz8maDX0+ygsX8eQzEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801876; c=relaxed/simple;
	bh=ByhlkCrkjQqcJio/gxxmPyJVVQtcOBdbFa/D8+oHRag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSYxxnM9ey5s2O/kKtCSpyWiShzcN3Ajg/ve3wDyXLrXMNUC1JQXC6zo4wBGFlFVOFYW+ho6JnJfc54Sh6twABgmd/igVpiLFxMZD0WWDFYKdY84A8vgCJCvV7n0eNMEp686zWPtEKqteFElPbf3baUprPzJzzTg3R9fheuwqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6JMYIXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D896C4CED1;
	Mon, 17 Feb 2025 14:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801876;
	bh=ByhlkCrkjQqcJio/gxxmPyJVVQtcOBdbFa/D8+oHRag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6JMYIXKEveBWThJ0VL1HINhCEwDIbKBy3lRdhUqB1U9ZY7XLPC2Y3KQvHUfGzRX5
	 W03KW2mYj7ZaH2t6lwwCGruv6vGRt8BHSZZUhvLfb8fyt2JVwa+iMwKHzIiqbgfXY9
	 CVHcRXhk4D+dnEU4WnFemE6wfDF7yJ7WzzOS2mh8LFvfXuS6bff6mWyic/SPchhtJ/
	 rWWMOczi01IkBhWEJhBWXh/H/Dfa+lvlAkHmovPhojyzbEhl/oY1egKPEfMzWIUxZH
	 k+E4Bv+kSiWVySCA+x6GktU4KnZ8THxNaGVuPMO7RTi/YX0BL6vmeL83PLRaJBDF76
	 mxr1VMIMxKsnA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Phil Reid <preid@electromag.com.au>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Marek Vasut <marex@denx.de>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 12/29] iio: adc: ad7768-1: Move setting of val a bit later to avoid unnecessary return value check
Date: Mon, 17 Feb 2025 14:16:12 +0000
Message-ID: <20250217141630.897334-13-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217141630.897334-1-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The data used is all in local variables so there is no advantage
in setting *val = ret with the direct mode claim held.
Move it later to after error check.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7768-1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 113703fb7245..c2ba357b82d8 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -370,12 +370,11 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = ad7768_scan_direct(indio_dev);
-		if (ret >= 0)
-			*val = ret;
 
 		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
+		*val = ret;
 
 		return IIO_VAL_INT;
 
-- 
2.48.1


