Return-Path: <linux-iio+bounces-17526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391AEA784ED
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 00:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0FC47A3FDE
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 22:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C599E22068F;
	Tue,  1 Apr 2025 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ftxaf8Fu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F02A21D3F5
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743547846; cv=none; b=fhLI5DYosHavI22vF9lRRty2U4TyxMmZ6braTOl3UxpO7SsMGFgaFfWkpc6SynyAJGe/Ppk0h4Cvs5OQJNDDun/FxQ3RuFbeefqrjUJYuE29U4BZRvfLzWXDLILAd5LQ2i6SCH9RY0excxKQP9PKekaYeXn53Oa+JbTuok97Z9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743547846; c=relaxed/simple;
	bh=l4ovhFo/GzqCAr/tJep6ZW+QzYV4DEuHtmNsouGPBYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YcFCl1EtwRmiBCuwNQHObdUa9HRr/zj6BThM8IKWe0WpXovTul5MN4qnSRQ3XlutqR/0wsZ+f74QJPQprR41AX4zRrXXTTYdFBRLfR6JQT/oTbt9f8quH22aDX2thMvU2M/MzIybkwYA4yX1BI902zMOgWSuK7wwZCJWJXJCNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ftxaf8Fu; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-601a8b6c133so130284eaf.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Apr 2025 15:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743547842; x=1744152642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBCDwaIxUQd/u+f/hpgM4pDWmpkYUglr1PKpMsLAoic=;
        b=Ftxaf8FuQ49cmFyUjyzNc5t9IR71aC6bJ+k/VcsagAtpUWDOLkx22ArEGiEug6CHAP
         dEywpVTsvC5ElTsFqHrlGwbTOYM5OKi8Et+1hgqwqrtg09NKWF5Ei+cAXNoLYCFMkeS8
         sV7YPT/qCWpf5gZU8PyuzoKE5/na7+ZEcIoTtatTfF3rBGXENK/VeBk5RPkxdkzooRFZ
         EcoM/H52az8JHBUVaaEdNWSvXLjmdgszFonU3Xp2lAuk2kY82VmdFX1HbejBHZuiMSaV
         DKukjbYUT0ImLHhQSumUQJ0qn/2DbNrI674DG29Tnv/ZpVKDTz+lZpTouvsqxdKhNQV1
         a8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743547842; x=1744152642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBCDwaIxUQd/u+f/hpgM4pDWmpkYUglr1PKpMsLAoic=;
        b=utf6ngcdH7Y3WomHTlIgThD2hV8C81CJ7EoOUIof9aeIjBt0eMhT0kylcLwrdbAcxl
         /j4QiauAZvJ76K7ayMnF2726elezLAIvsNT3F+xULI8GZIGB2QvpRUh1fQWR0uYnyJh0
         9T3SiNH/od2rgYaTas8xTdm/gwgaUi6ieIvsZe7sa0ysJXddNQOdpVr9S6gMFW9Uy6D6
         G5t2JUPSKpBszXhuBg365kbIyj6RThskkLuLOZLvBuuBQbmeUR1/v03DG280rRT1femn
         XuXGvvAiiNMtW7to8UQCZTLaSG74hf3+BFq4nSRb8k+RIhHJE860vnpuowCbQbHH8ZRF
         //Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXK4MvCR+mGfcgoSN9YFEwH//sDB1RG47s6GnnTrwA568Sw7ERnOl612JN7r+ZafcDVRTPEjS28x4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEeVu7PaqnMN82PDQVZLSirmHSxeaCFKMAvQGn/6oTaMp+j584
	ydPbWMnLsCyC6DxrHgRlh3N1JMm95idts8/cH+fCJS4fobhmuhjZu/3AFN05CQU=
X-Gm-Gg: ASbGnctDLW2LxcLMrhwGRhvvlWoVvGtCfSGQ02UIMRSG0kAK2SubKxYAP5FywYOKZ0H
	rChD4Bc5oe9TvDCXL7WZU2n6Eva11oKV7l9THCviTEjaz92jUsNGb5sbBikZYxdwL5qx9GI89Vi
	8tX2uDRsTwFYrTvAZIWFhzm5LP187U7mGBWTtsw33YtPLRVKe3OC07JarYsmD2V7kgxcC7oWoEy
	uPbtLmqujRk657B7mDQzmTR1w/okWyDfPDstls+y6kJvOmdcC7O4/Ol/Qurb+CfONvTYhJbkL2r
	y6nJwOMvVvmcFfddjS0tPP/8zDxOx67razCq7JXLScvDug5gE0OQEplTHMji06fMyZpALqG9Zk6
	G
X-Google-Smtp-Source: AGHT+IG0RQHyDvXPFu8JV/9+WZdcEeqrgyW20fSgLeCJLHlRPKjnuoZzwGLndZZ6UfK8jDOTJsiFtA==
X-Received: by 2002:a05:6871:aa0f:b0:2bd:607c:c804 with SMTP id 586e51a60fabf-2cc54fd24femr1065837fac.6.1743547842472;
        Tue, 01 Apr 2025 15:50:42 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c86a860267sm2541894fac.36.2025.04.01.15.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 15:50:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Apr 2025 17:50:12 -0500
Subject: [PATCH 5/5] Documentation: iio: ad7380: add AD7389-4
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-iio-ad7380-add-ad7389-4-v1-5-23d2568aa24f@baylibre.com>
References: <20250401-iio-ad7380-add-ad7389-4-v1-0-23d2568aa24f@baylibre.com>
In-Reply-To: <20250401-iio-ad7380-add-ad7389-4-v1-0-23d2568aa24f@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=l4ovhFo/GzqCAr/tJep6ZW+QzYV4DEuHtmNsouGPBYY=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn7G23WMhCW7TbNSZvazzPiomXbl09MZazclNtB
 fCYnNnM1zSJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ+xttxUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAOq2g/+OjQ17WKD87fY99tB+cemDltxMECfTBSuDgl8osf
 /FWPmdyiaR/AWO5B9bC1JRXevV31aslR861AdpEmjzcUEEYwJaUfce7VnRFrTDB7wfz6/4m+oFA
 RojezRzqmUPMZjtSUhRELY6O9N9NHA3c0Im8959uL1N3RlCV4eFX6Rxv3U0I21OYTN7kutRcyqM
 DH7j1P6wFnBD86mVNukSIAPgy9l4iIOpfzg9Kr8B2I5GBUItHXh9YrCcKaQah3usts0UDSGNtz2
 CJPOsdBJa3ccu2dlzBp81K5sL8EoavDVJYHgen3fowvsw6ypXqFw4C6N6KDmEdAXRYlnnEeQo1c
 zxz1lbFaoE7Cfnm9gZ/x8Sktwliobva92+S/ZEzUJhLMVXCo43STxd0n0iEP5mdsZZQVpIeeI3W
 JPYj4VNKj5yZILUTA+Rf3Bq1/YfKgG1E9E+OeFUCB2Qy+3HnRGmMed2lj8HJ5fqpg9ytDGjvgMl
 j4AOGGmmTZZ50cJxSqBji2uq3rRqetlqzAV3tmHQl/CjyfIfr8CgLhjCLdKGWaUSnptxazRP+Hu
 oywwWA2266i+1QH3rf+nOpP6vMGZhg1dbvPemWc7vVsEwX2y/+oSZDF8ZAKipXsluVNwrzUoJnr
 qGzVhyUpoFvcU0b9VcXDGokYp7hDHe1loXC+alFkhkz8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Document support for AD7389-4 and it's quirks.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/iio/ad7380.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
index 24a92a1c4371db6b59ef47edf06cee860641ebbf..d51f9ee3e939c9d33515ce79701fc7c89f5094f2 100644
--- a/Documentation/iio/ad7380.rst
+++ b/Documentation/iio/ad7380.rst
@@ -27,6 +27,7 @@ The following chips are supported by this driver:
 * `AD7386-4 <https://www.analog.com/en/products/ad7386-4.html>`_
 * `AD7387-4 <https://www.analog.com/en/products/ad7387-4.html>`_
 * `AD7388-4 <https://www.analog.com/en/products/ad7388-4.html>`_
+* `AD7389-4 <https://www.analog.com/en/products/ad7389-4.html>`_
 * `ADAQ4370-4 <https://www.analog.com/en/products/adaq4370-4.html>`_
 * `ADAQ4380-4 <https://www.analog.com/en/products/adaq4380-4.html>`_
 * `ADAQ4381-4 <https://www.analog.com/en/products/adaq4381-4.html>`_
@@ -50,6 +51,12 @@ ad7380-4
 ad7380-4 supports only an external reference voltage (2.5V to 3.3V). It must be
 declared in the device tree as ``refin-supply``.
 
+ad7389-4
+~~~~~~~~
+
+ad7389-4 supports only an internal reference voltage. ``refin-supply`` and
+``refio-supply`` properties are both omitted in this case.
+
 ADAQ devices
 ~~~~~~~~~~~~
 

-- 
2.43.0


