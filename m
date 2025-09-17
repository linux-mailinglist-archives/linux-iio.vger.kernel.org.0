Return-Path: <linux-iio+bounces-24215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00287B7FFE2
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 16:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7961B2489D
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 14:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8862C327A;
	Wed, 17 Sep 2025 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w3ggX6aJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ABB29E10C
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118660; cv=none; b=BtyShU4WAec8isvg+TuSt9pEFOHtMW8jGLxDoM15NamOAPCOi8iDHq8Ws0V7+svIhcvOjRTVVbfaxpnkVwJ60rBhMjuNTOWasBDBUx2mGl1iht4wh+VIc08sdiHlMLp8FaVpR810N4LRR38yJHHwsXilZotpUYAsGQTq6UR/+34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118660; c=relaxed/simple;
	bh=6hv63xN0KYQWhz2vAf0QB/EYtmLibBjQj8kn4Burfa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QBBeKKxo97WZClLdsbfhkIIPrQBEcQKE36xWPtn6ERUEIfw4G1GiQtf2woLnlKlVZ3ILD6jJe07XGoMo7UQNhwOH68Ymf8XowHhIwCISHolc25XxVENxwYPgJ7SOcOsw+Y4HevDiicbgzgA0o5oyzoBxx8elFGQjnxK71fTf6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w3ggX6aJ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3305aceab00so6234400fac.2
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 07:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758118657; x=1758723457; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dcnvqhytDHVondi2QamJr5XwZgrzeEnuwXkS+adOZY=;
        b=w3ggX6aJwEfAkv8C+yCDG6IhqDP1TWgV2D08BtHZGWC8iACU634hW01VK2hlMpwsyy
         qTyPipes8FkQH869QxQJJhcEdzpKOr/ZdsIqyXsbJRPa+tswVPBWK3l5iDWXNBjBdAuL
         phKu6jbBO5f8oMUgUny58d8jrDiHoSRZ1ltyEcYvScFbPuP5mp1HSeJTWuY2JbLC4Je3
         zTrF21SjiP0Q1RmjcXYEVvO5eFyZfRRvdxeVBYZfP1GrAR0KZUOc/epWnDaITVF4enfZ
         EXJxrqX16d+hstYruK24is3dLTFqZcC+VhqRgQ0eHyBluuteAx8x63RhCRueaoX20UId
         kPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118657; x=1758723457;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dcnvqhytDHVondi2QamJr5XwZgrzeEnuwXkS+adOZY=;
        b=wpZ5S1N5i9XoJV+ma9gkQXBpXU/uyQBIOrLfW1VF6kOvfBHCqEaa9DdVEBVtKf0J2T
         uy30qH84iolTAIvp4ZniFV9jqc2GElJgssd0pmYkX78GFrkn4eQ3fn2GRCFb2Bic4Vzc
         rmgShilvTGW0nsnv6N2rsPhLIDxSSl7PDqAE/W6uRsS0JyKTBUhRiyDJXtoFlM8H59Lv
         60VD7GO6UimpVe/ypdHiNz/IhXeorNb4LsrDefCCYat35KXVwaz7YrNmdQ6Dz9kSIPLN
         l4/Vzj0YA/cHCh/34ZbFh7KitSKSKTioDQlaP1SkLJHi8/oxIRLfuHPZ2D54DH5wOChf
         r4Bw==
X-Gm-Message-State: AOJu0YxSOignoaFxwUHi4yzydekCIXzljy+78weIWEXbS+sR9LK7Qv4d
	GGTEt9qHYOgqCh5XznJDSONImRAjaKRVDtQTHTPA6eh2kJ0BJtT/gbyOJVqbEP3NBy8kS651jry
	e9PbwoA0=
X-Gm-Gg: ASbGncsdmOU9utgB/c9vnKK3u8USLU4LULaA15IVqczMpNmI9m6/htTUjNlDfs9RX1N
	TByiAKkzzh091h/hBOJq6lCsylJ9DMw8W1CoY3KWQcUgPddpKB2+UcEHLPnNGuxjJKlY8ZmiuIE
	RwchsRRF290RBwe+jVimkFakFoAu/oXzJ3Sqn1L3EnXBcmATpMvweFHaT0oZw60HhzJ2pQuzbF7
	MN1r+YtqO2NIG5XTmkWRvXsxLBm51cLt9pHwVJjRM9tnkguwYeeMk/tdS8kMMwJmc+fnHOQkTko
	AylJuHRpP0lC2yUXOo2KEsheiA2l4KAFygr19aLWwcU6xhSqSq8VfFWT5b3IedTOBEv5SS5Dfhc
	hArZgKb85Tqj2yXlLj4+lPRdnXzY=
X-Google-Smtp-Source: AGHT+IGzJt9Yn527W26iNrzT+3DLjLySBnQVi7hx6OsN1flWKGl/+FA+2GwgxmExVcRHcBhks5H4ew==
X-Received: by 2002:a05:6871:54b:b0:31d:6b5b:6b57 with SMTP id 586e51a60fabf-335bf82124fmr1142378fac.30.1758118656946;
        Wed, 17 Sep 2025 07:17:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:72c:cb37:521d:46e2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-32d3537ebdesm6344406fac.21.2025.09.17.07.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:17:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 17 Sep 2025 09:17:23 -0500
Subject: [PATCH] iio: adc: ad7124: use AD7124_MAX_CHANNELS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-iio-adc-ad7124-use-ad7124_max_channels-v1-1-70913256a8f8@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAPLCymgC/y2N0Q6CMAxFf4X02QUYw0V+xRAyt4pN3IYbGBLCv
 1vFh6Y9be+9G2RMhBm6YoOEb8oUA0N9KsA+TBhRkGMGWcm2utRaEEVhnOXStVRiyfgfB2/W4as
 J+Myi0SjbRjut1BnYbEp4p/UXdO0PTvhaOG8+lnAzbGWj9zR3BX/nMqGPfC05suQ+Uxih3/cPO
 y69y7QAAAA=
X-Change-ID: 20250917-iio-adc-ad7124-use-ad7124_max_channels-37e2537d7446
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=6hv63xN0KYQWhz2vAf0QB/EYtmLibBjQj8kn4Burfa8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoysL4Y6PZZASzbARRTWo8XbiFHTsKjzxIp7iVT
 +U1g1EyyxKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMrC+AAKCRDCzCAB/wGP
 wDu3CACainziwIbk5oQYsKEeTpfcpDEY4W1ivRUFcy5ptJFOpGTh3PIlUqewWCL0BIJf9QRjMVv
 J/d+Ir3tKUK50uGCn4G4aD0dY5iwIrByozihTuO2mgEKBYjixu4WmMBKV2/ZGNV6/EQPGMebj7T
 eadxB+IeyXTHT02xB6Oh5SG6X/TcsXde8EEF2h/IPk7iGp6yDq4rBBH0QlC8dJU9oDVTrBHLR+u
 f0eHBS2MdnGhWpodPXHgNNBgJzesXpGU3G8RHqDuj+NM4PghshOcQD6pxXaM++0rH8F+YTHTyO8
 ax0f9IhdovMJC3c7/tTNYGLi24iEgGzF8i8W2tfk4H4fD9LO
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use AD7124_MAX_CHANNELS macro instead of hardcoding 16 in
ad7124_disable_all(). We already have the macro, so we should use it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index c24f3d5127cb83eeab0cf37882446fc994173274..9ace3e0914f5acab695c0382df758f56f333ae72 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -702,7 +702,7 @@ static int ad7124_disable_all(struct ad_sigma_delta *sd)
 	int ret;
 	int i;
 
-	for (i = 0; i < 16; i++) {
+	for (i = 0; i < AD7124_MAX_CHANNELS; i++) {
 		ret = ad7124_disable_one(sd, i);
 		if (ret < 0)
 			return ret;

---
base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
change-id: 20250917-iio-adc-ad7124-use-ad7124_max_channels-37e2537d7446

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


