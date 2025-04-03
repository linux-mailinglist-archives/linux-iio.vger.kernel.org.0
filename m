Return-Path: <linux-iio+bounces-17572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DEAA79B56
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 07:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D9F3B6407
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 05:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210F019DF4D;
	Thu,  3 Apr 2025 05:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EP9l5hsq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A42019CD1D;
	Thu,  3 Apr 2025 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658475; cv=none; b=eYN94S4RIFwcAQgmxCDaVxj4SiMUYWuc1lpM1jK9etJxbhVNffpVbvwxeSj8KDs0I+vD3ae55YPoSy6PZfdRsxIcRRnV6I9LFr6zfeRak833VE6UaVZ10IJBj7FMZOkH09Y8G/aZzmRt46RmzSk6rZdfe3bIJoQHyoC8FbkSANw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658475; c=relaxed/simple;
	bh=Q49KsDhVxmMVF428fpWujXNXfZmzsnwHsWV2ZErI6FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqY0OoklPxXyst3eLWZl8AuWes3g7BfhVP69VA2rKOQXPNf75vX2hmzCVxf97rIbJIlOGjKj6eGyEhTFKU6o5fhFlxav/oXILRs2H7j8VYl43NMSy63QaQj0f++0rEWH4rndIYLXha1t9tHge//VvNWvmzYmg34XrSk5qWJmmOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EP9l5hsq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224019ad9edso7215435ad.1;
        Wed, 02 Apr 2025 22:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743658474; x=1744263274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BdiurNJ55x7dn380U3JXrTyhKoZwsyqMKnMVKDa2IA=;
        b=EP9l5hsq0nF7SLtCAUPf+huD5Rrfmf42DeM5YdrfW3YUOSenpvmEoJj+JhrHMUKncG
         6092NGNX6EnFXFQBOUQFa9EkdW5v9NABPH/cLRIUWkxJLpiye9m0j+0AdbVD2hu7B7CO
         krHAgHCrcCxA19Kp8rg/EXkLq3VjJCwlUxlb1eSIkBwX7Phd3co57WmHjAgiWvz1CaFL
         hikXkoj6tctc7KNbjdWL4rzx6AsROCWLja6CodHv35XycRsEPDexeU3EIRO5t74rFYsn
         wTGOiLa+dGNuq0xTcnQAXrjfvCq/ZX5TEli5OBmslgAJLjcR/XKFyO1uQrnanzfnFNRw
         sQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743658474; x=1744263274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BdiurNJ55x7dn380U3JXrTyhKoZwsyqMKnMVKDa2IA=;
        b=XbqpmBcrbTpYUISyCSgeMP5rZNIS5zxAkg0Ls+6bhdInq3/lPQ6lNj9vFIhvJyTyDU
         RT2uE1H2X8c0SKsiLTomwfSeoWOdlB4IH/zoCDU5OP7yreEdv/rLxLNu/NbuZxeAzvf2
         gjls/tBLIZS3RgB0QMxwU3BBz3rzhPVrgtAHEAx38cIgADl/y9Dr2pBrm67SHKaEWkIZ
         xExJ/ykiZv5OcZi242o1omHzaCdrG2IqpJOGBNfUpgYX91Amr5lSM03qZWVzA0xA+QD4
         1Lsh90u8xSi4zwwnarPWZLrpM3CU+5t1tB0LSyjUgyI/wr073h4IDTIucS1K6BunbH0l
         HD6w==
X-Forwarded-Encrypted: i=1; AJvYcCVD6eqxeYJ/JWtZyQSHw9YZ+6oJIPS2zsaSWnpIYi0jcYFrJCgFIwWuvzNE87gQxh4OBq62cbYl/RCX@vger.kernel.org, AJvYcCXbcWYTHCyEXsrx2RsRc4ceKz0fDiKkQinoAJ4CnqvvuqTvM6FdqTrPEt0efVAsrdZFSBrbx+ZKNyK0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr53Ude4DmqBOL+n3jRZ9UP5nWjxtO1R2YqzpkuXv1aQKYkXea
	FasiK5iQov42KkkKFIXvihTB7JHUmA9Nyy8cfP2tYe1n4SREx/gS
X-Gm-Gg: ASbGnct3UrXp+CDAwcepRxVp+SSKas4os2wTFSOSidaURdfb83lYQLI8IKGrVpc2Xwv
	Pb70dOCHernRMCPslXcj/4VeT+5zuBlKhJ0PZ8RUVJsVWJlUh2/qP1ulh+rDZ/e7RcccrkCSl0g
	43SZjWCPYFdBCT0GDxJ/7e5ptWkrj2hTtv3o734dgDOdq1P27pBTFWXGyWXw2WYJcNU/0kSOM99
	8NBIlUiyJhLLwfLvlQARlI2BcUk+pUSEys4KflhlgVhZJ/tHW8sU6NwEebt/OmD1F2S7aR8l+IC
	GZvN0pAnTKPGOy89pUDKppa0WntAxtQ9IdfeHkGE3zWAFowxeQ==
X-Google-Smtp-Source: AGHT+IE0jCUBbiXte4mxVAUQfr3gdVPGEcwQRG5dhaoNQC5MY3ydMxteHQWVZHd3j9gF07fyMHuUzg==
X-Received: by 2002:a17:902:e88c:b0:215:a179:14ca with SMTP id d9443c01a7336-2296c603a3cmr54082595ad.2.1743658473640;
        Wed, 02 Apr 2025 22:34:33 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([61.108.38.194])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22978776601sm5537575ad.237.2025.04.02.22.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 22:34:33 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lars@metafoo.de,
	gustavograzs@gmail.com,
	javier.carrasco.cruz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH v1 5/5] MAINTAINERS: Add WINSEN MHZ19B
Date: Thu,  3 Apr 2025 14:32:25 +0900
Message-Id: <20250403053225.298308-6-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403053225.298308-1-gye976@gmail.com>
References: <20250403053225.298308-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add undersigned as a maintainer for the WINSEN MHZ19B.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 98e9e318178b..c78c758cd069 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25615,6 +25615,13 @@ M:	David Härdeman <david@hardeman.nu>
 S:	Maintained
 F:	drivers/media/rc/winbond-cir.c

+WINSEN MHZ19B
+M:	Gyeyoung Baek <gye976@gmail.com>
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
+F:	Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
+F:	drivers/iio/chemical/mhz19b.c
+
 WINSYSTEMS EBC-C384 WATCHDOG DRIVER
 L:	linux-watchdog@vger.kernel.org
 S:	Orphan
--
2.34.1


