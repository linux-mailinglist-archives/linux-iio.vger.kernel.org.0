Return-Path: <linux-iio+bounces-9900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8D598975A
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 22:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02B91C209FE
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 20:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846AD811F7;
	Sun, 29 Sep 2024 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLl9eqnm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E807DA8C;
	Sun, 29 Sep 2024 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727642341; cv=none; b=KBVW2TUeo9FjHSFnUG3oR3+wQLTAnZQVp9hNsyJwW+rx1Om8lZxzBmnqoJX0fav6Cg7/TR5KCgn3pxzKB4pObHcX1mnMyRwcV0ayXwmB2exRHVBbgzQaHpK8R+eiw3uq42pZn6DMQxCsgRnFgQcKcnDlyDqHEVChxtNGLCpAbv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727642341; c=relaxed/simple;
	bh=f9tArTOelwRcZuYp5DRYRxrU8hSv0bj1O9hFv/wqYb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hnjGtCyAyVvgOeNoZbdhU7xzyRixQu/Q1Xqi9RYh30d8WSCwYSmjGZAX/+5AwXGAYpi9IADysyUN1ft7hb5/+KGBk82QCQdvaD9uhDcpXpZNttTNpqheNGsAJeszOGGf0Ay3kI/OMNj+p4vmJsMJwr7j3Untyn/o+VXlZakvQ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLl9eqnm; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b3e1so756400a12.2;
        Sun, 29 Sep 2024 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727642338; x=1728247138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoqPx2xLt4s4Crl4T/xJ+0dSJqo4z84sx5wy+wejSF4=;
        b=fLl9eqnmwFnJk3uXPs7rTHzw+3IzYK0nP9FUwhJndq+qtcxB1IFOR4QnvqKNxGz033
         qvuqecSAlkVvLBmp78Oweop4RUlzdkWS2BRpbZiEYjjdepIaaedALOXusZY35xcLSTvC
         NfRLTIEKwXVJhfZFlTP+uipenRLyEVe6W/VP1VqN0y0Xhih1nAEbcFRSiVFUBfG6Z096
         YikIENvieJcOv0G3fPpNoy3kHSHOIAt2tKTT9NKz1LXQaPPrtcOYriJeZOV8eiEHIUug
         i70HWk1P4qkyGCRkM7a2ry9ZtwCg30u7EFXcJg//MAsOmkPgN8mMf+tuXGoa65dKCxiz
         8DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727642338; x=1728247138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoqPx2xLt4s4Crl4T/xJ+0dSJqo4z84sx5wy+wejSF4=;
        b=EkDHGsWWom4omTrD907+FKF+lBgvQ5fPA/Mj2DJpz72uvZscqsEDO7EWbsnaxyObop
         BelO6zIaEyAK22ytuqz0nOrAzhiXy6/kD4VR0TDmEJlWyQmVE5aTOx0SHIggBctNtO9r
         x5/BSTWeNb1NzskFhaSaJjSOqA5tdD1R3hRQGrN5tzv73xSpS4l7/+fyAoCxq27gqT53
         pAmCc/S5krdB8FM5M+7yX6cPclSqVssDaMWVAafdvsB1Ksq2mDPUDgIakL6kglmtAscs
         EEk20Rnz9m4F1vwzpAhN1Ac6KTQB7/K8FyaLjA0mo+6F3nl2ICrfNDr2ZGfCm5QJF9nc
         fV3w==
X-Forwarded-Encrypted: i=1; AJvYcCV7looa8bUBoDDI40Cmw+8Qw6w7EwI8cRMkvvxrRLgYeSxs5srFvBXfhvJ/elzZjO9XPU4IKnTXADNiA6eg@vger.kernel.org, AJvYcCVed9kO+54HCOJgDkCwvKtgJY5vXbkkSBgyUjU14ydq1mZHXbH53+YpYvwZfn7USZtS15wb2OlN3Eac@vger.kernel.org
X-Gm-Message-State: AOJu0YxyKH5Fl4vi1usbE8I254yGZEISzRHmR9YXDa0zqTSmkMqQ4+NT
	zCUSbLcagKeldoHFGuSmSIKLO+oJT7E/4clNeOj14a3cS9ngmVJY
X-Google-Smtp-Source: AGHT+IEJp+m0Jpit3d1pRQq5nNlE4wR495DAdAHCHhI6QD/jsa+DR7oHB/bO7SMdmcjOM/7vZpIFRQ==
X-Received: by 2002:a05:6402:26c5:b0:5c8:8505:a803 with SMTP id 4fb4d7f45d1cf-5c88505a899mr9095944a12.26.1727642337949;
        Sun, 29 Sep 2024 13:38:57 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-e2c0-9a60-64a8-717a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:e2c0:9a60:64a8:717a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8824051c2sm3487985a12.19.2024.09.29.13.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 13:38:57 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 29 Sep 2024 22:38:49 +0200
Subject: [PATCH 4/7] iio: light: veml6070: add support for a regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240929-veml6070-cleanup-v1-4-a9350341a646@gmail.com>
References: <20240929-veml6070-cleanup-v1-0-a9350341a646@gmail.com>
In-Reply-To: <20240929-veml6070-cleanup-v1-0-a9350341a646@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727642327; l=891;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=f9tArTOelwRcZuYp5DRYRxrU8hSv0bj1O9hFv/wqYb4=;
 b=V743tVlfi96fCEO2tNfNNOdCVfh/xNqWxAzRGVlLC+JdTQ8fts1vSsHsalQzAhRj3UK68eqBP
 078HWVYet3dBKf04/zYJvmiEgFbvaBk1dYtq/hplvewwv8a6L/69gGO
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Add support for a device-managed regulator with the reference name
provided in the datasheet (vdd).

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6070.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index d15caebdc959..faba04e1da98 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -163,6 +163,10 @@ static int veml6070_probe(struct i2c_client *client)
 	indio_dev->name = VEML6070_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	ret = devm_regulator_get_enable(&client->dev, "vdd");
+	if (ret < 0)
+		return ret;
+
 	data->client2 = i2c_new_dummy_device(client->adapter, VEML6070_ADDR_DATA_LSB);
 	if (IS_ERR(data->client2)) {
 		dev_err(&client->dev, "i2c device for second chip address failed\n");

-- 
2.43.0


