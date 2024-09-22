Return-Path: <linux-iio+bounces-9712-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC8E97E3FA
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 00:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949B81F21566
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 22:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875E784E0D;
	Sun, 22 Sep 2024 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZPuZTNi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15BF83A19;
	Sun, 22 Sep 2024 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727043485; cv=none; b=lMUgm1J5sYFFeBhfx9S4RYTVImHerzl04FqG8z32uUpIOxMqHMIXOCT24ey0cTK8/mQYB7G3loLdrT+VrlW78Vorg3f+QLOcALcGrRSuavey42f/HRNaXasOshOxMNt3QUy33eGWNQ+JTsFJRPydvt8nBHB3EcO6wHVl7PB32Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727043485; c=relaxed/simple;
	bh=J7jjyfVmLZeAMaf/ScISfDN3o/rkisVFLqkrDFejwV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VlgMC40LN/NbGm3TsSO2KiLvrti0RP80Og2DHwHhgwVErHVkwgJGeHQ8nkwMdEDcWtRtNz5jGoJKkQpUNEuQyspQPad/ctz7d7t0J7kQb/ML7EQPyOXaEJ1dzZ4mhl9/c1b2LlyhlzMNofZC+2uHRRoy+ucIAWGR2K50wfWHEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZPuZTNi; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374ba74e9b6so3015708f8f.0;
        Sun, 22 Sep 2024 15:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727043482; x=1727648282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldi/jYR5bipK31CSpjyDr0h8RTCEPZFHrXaKF7gFNv0=;
        b=XZPuZTNi4TVRzuEWht0I5YDbdHOsvf1pEZuVP92cnccShEckqMffpsh2NgnCMMVm+F
         sF1ePqstwI1XWZPJPB6ECCAFkG2jqwC35AHEW09bo1g++VTQ7HidoYOqxiTBSkJe1txL
         YfZt6nbIN1Z0QEcPXJi/Z7rHU7EU3VG8etLIDvHlHDc/k9hoHFKfplxGhrSCxshYHj/B
         Rgs9HxjuI6f4BIlxibEzJHlQ0/ikIaqDFDYv0LckIXltF9X8Sxzf6XxuhX3nE1IUcqoT
         ApxT5hdN+8/Mdh1W7q8uKG2Wi9+v+tWUHQ6Y1gpy24aiZYCS5vtdqRStFfbn9z+QSUzS
         +6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727043482; x=1727648282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldi/jYR5bipK31CSpjyDr0h8RTCEPZFHrXaKF7gFNv0=;
        b=aM4M48I0beWiCgWbpx3mrs532Ldg6c1KZ6wYko2sRrK6Xo26ePuR23jrLSoEFKw/LV
         Vi17Q9Q1XS+7qAJNf3Cqp4PqL8ZO1sO3Msxm1nIjbISbgzJSNpt7d0qpGohEWsyQUf1U
         6CGh4wNzs74zMIOdVhDt3a8mRBQ74RE69/z3jh5tfaoH1E1eMdrBhd06xzUtizjhpH7z
         fNiiDXSWaub2Ny4iYvaXzEBS9Vxe9OmjXfo728nS4WaDESsrbEHSyEtxLlR+ZluVs42/
         TEvUZGXRq2r4O1PtcZs9Kb1bVKAa2xsyL83f/w8cywSKjh/bo9ObrGODWWnz1j36Ze/4
         ijHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKomBGUi6+FtQlNaYQxDnbYEByOsNMYRscsaYs574FLJJAvHMiDJnFJkYuMsdFZAFDfTcd6okrP0dg@vger.kernel.org, AJvYcCXz5ESXQiu4FMkq61RDu3cMRL6mnuyRZWAk+4pWxTuLXP9owBO86KBdSVTl961U8CIxZGW08RUcZzJD/pgz@vger.kernel.org
X-Gm-Message-State: AOJu0YzPpOAGzBr2gC3rXVTMqEUnBza+Ix8vBRVuyAAOkrYVEU7yIlxe
	t8b1ePlT5p30qmCUdUoj1qF7HuPfK0ffCONPvJaswVFqyoT7HNBd
X-Google-Smtp-Source: AGHT+IE4RHwJYszhiEi2wGUAtZnDU425O2kbfHpmsnoxAdYK2OowmC8eHB3eClOkw2ePStXbYORxdw==
X-Received: by 2002:a5d:4144:0:b0:374:c29a:a0d6 with SMTP id ffacd0b85a97d-37a422533bemr7112878f8f.2.1727043481931;
        Sun, 22 Sep 2024 15:18:01 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90611164d0sm1126202066b.91.2024.09.22.15.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 15:18:01 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 23 Sep 2024 00:17:52 +0200
Subject: [PATCH v2 04/10] dt-bindings: iio: light: veml6030: add vdd-supply
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-veml6035-v2-4-58c72a0df31c@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
In-Reply-To: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727043474; l=978;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=J7jjyfVmLZeAMaf/ScISfDN3o/rkisVFLqkrDFejwV4=;
 b=cmWptNJ/AfJvYWFA7PzBbG6UxQF60YDtQzpvKtGBorrTvAWAdZnUuzG7TG2DA1HWjFacp7/6g
 cTyOoi/Bg3IA0WQrdsi0YJTP5oUoKpb9Qx5nEvHqdCDCGjTBaFLHBFJ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Add vdd-supply to account for the sensor's power source.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
index 7f4995557570..2583b61c8357 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
@@ -41,6 +41,8 @@ properties:
       interrupt client node bindings.
     maxItems: 1
 
+    vdd-supply: true
+
 required:
   - compatible
   - reg
@@ -59,6 +61,7 @@ examples:
                 compatible = "vishay,veml6030";
                 reg = <0x10>;
                 interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+                vdd-supply = <&vdd>;
         };
     };
 ...

-- 
2.43.0


