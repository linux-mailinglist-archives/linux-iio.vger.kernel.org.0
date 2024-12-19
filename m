Return-Path: <linux-iio+bounces-13693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F127C9F88AC
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 00:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3565B169D0E
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 23:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0181F192F;
	Thu, 19 Dec 2024 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAkqLB+v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5499A1D433B;
	Thu, 19 Dec 2024 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734652076; cv=none; b=sJZmwZPIkDzShpIhflmJRNMAOfJx7aFqHz39mqaAKUNFlepR37VrdYI7oRDZaL4CPlKdCcr16PvpkGSMlhvIcJIM9Oa3Ol5bK9i30Cf/48RQzcc2rbeXh/bq8LDgm2CRT6ojA6XfMrOKst2aoUdi3G924gCw++FMf7SfAge2RHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734652076; c=relaxed/simple;
	bh=et7QKhk/MQLozeahZApejcpL7k93MquU+YeisF+viE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxtwzxd9TaAGMK42IPQYGSnmk7Hgjun8NKIfV5sqptYq/RlVK2CvXR9a0Lf9V0OUgQ/Mh3/MHI5SEVrGuwpWUzQBuDW/wi0uU8M4sdGw4IC+eNs+BaNQmU+GxZgbrJ9+hue94AU12kS/l0wsM9JwazqCT1ZthNYXgjnqYN2Hxq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAkqLB+v; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa696d3901bso233187766b.1;
        Thu, 19 Dec 2024 15:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734652073; x=1735256873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B8B+qa37J4iTEof171ZdTge9qVHAimwJGIfxFtux/4=;
        b=KAkqLB+vzeY/5t3h4dBUQF1OsrIg0XSPaijA17iYZ0hSnL1QIPl/nDzDXB0wqF3dkY
         a/rFORLrJPPqg2pyTHDK02ZCCU/uXCEjjr3rKXKPhPixpFxOZOcDNDrKM4Et2xQmMkRd
         YYR7bCzjEqVOzjwP459QAhM50VpfCv7+/Ut6NM1uNJu14XG2Uxe4i6OghJBOvVtlVeMr
         vi6HpPolxumjg+reVzLxsPBVLIB5b6o5YFUDML+B25PrRbGmam1x1xtwZZDR2hUmJDO4
         9jtfOcejTzXrhQWCQkFRfKa/kDG38VV5hDYujn6zr76dYg5fmvC/DnIw6M3mei11ekBY
         tUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734652073; x=1735256873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3B8B+qa37J4iTEof171ZdTge9qVHAimwJGIfxFtux/4=;
        b=en84RRf6X6lY54GDzDY6NsHFzlCwDoMg9t/cTeORnununwHsLq0hdXjXtTwFk0jGJl
         MZvjNaPledxamJ7YMHBwXMPD60ewmPLL+8Fao1gs8IqV5TCIhNuMlC1h1kt8d0oKl6Wc
         fK8u97rl08oNokmkxMlXq+BSGgEZWJ2uWpiHeciV0Q23poDoDy5oFt4kQ33TUNf7ngl9
         9fXYTfUMfrSZEm3cehqaD0NUJFXSr2RreUda+eesxdiPdGktdDewWw7ajWTGeRkPzTiW
         E2X8aN9A/Vtya8A+p5aEUtJximRH64eZ2W4H6jyM3JhGmn5aqGI6fc+CtpODaRwYYnp3
         vEIw==
X-Forwarded-Encrypted: i=1; AJvYcCUEL64lXNfNq9KQhPviDI3W4BGkQyDgW+tT2LHCqRHGsLecunuwOf+L+eYW2HOAwmeKwdbkBjr3StBwVK+O@vger.kernel.org, AJvYcCUk1zmvxhGT8nVv+5MzdqIc0FzaDac19ve4XV/fBaGlTKTaEyiv8TQqFn6f29vimie5sGK5y4CYMNqx@vger.kernel.org, AJvYcCUkUpTGsw4b2j4Uyr7dfDhbBSAEjWrgMXLPhuBQAHMgkjJaz3VIPlvd/gKl5IAHHkDPfBXdeIjyUAgq@vger.kernel.org
X-Gm-Message-State: AOJu0YwW176JgCym1ix8dcHQVMqRBA5TLF7hLzopUdqpf6uXkHfQknVv
	8Ni3w9Mwi6k5e9cxzycKNi+4woowkjgciGHCZJtU/nJd3W3dAkYM
X-Gm-Gg: ASbGncvojRoCVTjT8uPySuXJqK5nNMF2EXOsqplofCTsgRNquLv8YsTHeTbibBQqii8
	l1oFac6RN63R9z6SXF150hCVVyEjnLt00YVlP7DySOznBKJ9Th9H6UoAg4XWptcjECAWWrqG1P9
	GoDuzpG7M5ENulNrzguz7hh/1KoIwnTJx8iLz2aJ9fGm6/sO2gBxXzJBjoqOXEgmN8hIGM1zNot
	5hi3FxBY42fM1HGNlO9y5VVZ0TOi7ULI6xrflGfE3IAAX3kLEqnZ5fMgniBtr0+DEV6
X-Google-Smtp-Source: AGHT+IFB9/T7QjEmsX+1zQh+xgcGNdaFdm0zA/nrcjkqMJOp/qGmp+SIwy1GQtOaqil8epTB+7mzqA==
X-Received: by 2002:a17:907:3d86:b0:aa6:9eac:4b7e with SMTP id a640c23a62f3a-aac2d455458mr55298066b.30.1734652072299;
        Thu, 19 Dec 2024 15:47:52 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:6db1:ccfa:1b4:55ac])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0f076d1dsm113244866b.204.2024.12.19.15.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 15:47:51 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: lanzano.alex@gmail.com,
	jagathjog1996@gmail.com,
	vassilisamir@gmail.com,
	trabarni@gmail.com,
	danila@jiaxyga.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: iio: imu: bmi160: add boolean type for drive-open-drain
Date: Fri, 20 Dec 2024 00:47:43 +0100
Message-ID: <20241219234745.58723-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241219234745.58723-1-vassilisamir@gmail.com>
References: <20241219234745.58723-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing type description "boolean" for the drive-open-drain property.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
index 3b0a2d8b2e91..2cf8a0c7eb4c 100644
--- a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
@@ -37,6 +37,7 @@ properties:
       to "INT2" if INT2 pin should be used instead
 
   drive-open-drain:
+    type: boolean
     description: |
       set if the specified interrupt pin should be configured as
       open drain. If not set, defaults to push-pull.
-- 
2.43.0


