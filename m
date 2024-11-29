Return-Path: <linux-iio+bounces-12815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A109DE8FC
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 15:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6401645B7
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D7413C3D5;
	Fri, 29 Nov 2024 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="mZybXIg8"
X-Original-To: linux-iio@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBF012C54B;
	Fri, 29 Nov 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732892113; cv=none; b=eIYPgen4qBFb5HBn49C/0WcQEiBYpjUlHZvzqR/fodLZUvSh8fMu/aQIyxFNk2sU7HNjYePOoTjbCiHONq3kZy2t2nvG64EkgFjEyC/wq4EsESPvLQ0TX+oAziQAhg+09b6SDjvK+exSyTsyShJdZZleqXpEmVITjSgB0S2eycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732892113; c=relaxed/simple;
	bh=kEElAU1E+We3ZBcTctUBKGoihHFzdNGpGT3cbuM8INo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Fk6TZJf9CTzDXOOhQYVst7afz8PH8mwMefyypWDweXKoafQAyBp/HDsCMwZ7VbPnoO9m4NYqQxw/hHYMJfl6THga8rhKJlUmIUAO7wpxuKCJ1JwEbIt5HLxaPgJ7OYzkDHLBjRopFTq8oC8PulzoMS84jI/spE5j0LKtk+tLT84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=mZybXIg8; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=W7oq4zTm1ZOU1rVeoCSofXuQ1USbEP/UBjNVYur5Kk8=; b=mZ
	ybXIg8dpXXqRAAomWdxxsErNzazzw+eQmwEvc3jz5obAuVwuQIA+Hwi0Us9/ib4E+m3IoqSs5zz0e
	F+eLgXM+epVgsTkmvVFSdbb614OAb+QFYWjCs9hvkVQVHQpWBqxGwNeYGaR8/uD3W3YlLZpFNi+vT
	77/yP30N2PTN3mUZ5Rsg1mqucfd90VXCleVy+NIJ/kEUpPZyDBdn4zWY3mUTltUMlCpPbqo/3GFwU
	O/ma2Gb4aRDlFGYRH8ffw2hZvOW7aHJvQB2DYYxa3N0/zJaj9B0xE2rWT4qlUI9+Bu+k/7xoGodAx
	qrsteHds3Jrn0B/3i50ShyYidaw5G/Zw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tH2OZ-0000TH-5h; Fri, 29 Nov 2024 15:54:59 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tH2OY-000JvI-1j;
	Fri, 29 Nov 2024 15:54:58 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 29 Nov 2024 15:54:42 +0100
Subject: [PATCH] dt-bindings: iio: st-sensors: Re-add IIS2MDC magnetometer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-stmagdt-v1-1-963f0347fb0a@geanix.com>
X-B4-Tracking: v=1; b=H4sIALHVSWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyNL3eKS3MT0lBLdFCMzU8vEVCNzg9RkJaDqgqLUtMwKsEnRsbW1APV
 oz9JZAAAA
X-Change-ID: 20241129-stmagdt-d2659ae270ec
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Denis Ciocca <denis.ciocca@st.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27472/Fri Nov 29 10:38:16 2024)

"iio: st-sensors: Update ST Sensor bindings" accidentially dropped
the compatible for the IIS2MDC magnetometer.

Fixes: 0cd71145803d ("iio: st-sensors: Update ST Sensor bindings")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index 71c1ee33a393e64b1c2ef8109175ba1180670a50..e955eb8e879795d3146f661a8b71e6b597b2ca54 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -65,6 +65,7 @@ properties:
           - st,lsm9ds0-gyro
       - description: STMicroelectronics Magnetometers
         enum:
+          - st,iis2mdc
           - st,lis2mdl
           - st,lis3mdl-magn
           - st,lsm303agr-magn

---
base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
change-id: 20241129-stmagdt-d2659ae270ec

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


