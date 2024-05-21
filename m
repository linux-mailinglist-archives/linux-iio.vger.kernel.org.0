Return-Path: <linux-iio+bounces-5162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 539328CB170
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 17:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E37D4B22CB1
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 15:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E48144D22;
	Tue, 21 May 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmlELbIr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CC61442F4;
	Tue, 21 May 2024 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305699; cv=none; b=pN6WMFJI7rBLgIkYJw0aalNRJCQ8wGVVLlUtj0swbq+B1VD3ZHtXvOzRpa8VfIHMKmAbMNLaPqHf/UFzial2NL4jJiKyhGq2g+nG3cuvIdwB681hu2aJ2m9tNpiVBbctr/XusHiwBZNRZNwaAmS7mDhCJhlGN/t25eMYnuaxo2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305699; c=relaxed/simple;
	bh=Gn3ZYHPLv7k1+IxrmwRUhTxisKkpHT08Bt82U4jLitk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tskcwAtXzkvDoK0ecmjaORtUqcbRBwojiJzd8jfC6scWGYnA9E3oAYczSpIgmQszaNBDz8XqXMwLgNK/X4r0nqTrZtBmbYnNEd8IIE++VCEarxkCOjdWX4OobtyhCtSfwPu+1xr1/xeJU0kXMwsbr83AccVnUdfPjKToDU19K0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmlELbIr; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so27676401fa.2;
        Tue, 21 May 2024 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716305696; x=1716910496; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UmIG1ewdscO4XnDAwidD2SSCX9dExp3U4G4JfrJ/90w=;
        b=XmlELbIr5Zl8ZlUZpfSXNrZqHbf5y2L7OGFA3Tkqdj4+sbDt8koa3AOK/MG7iNUoCY
         1dAjKtVLeEpZsZfqmouDivqMSVPOT2eIY0450HH4tSl7xJvqxXdXKGjifipIahS6jTX1
         R44KS2GiLUnhvRHyWtcI1zKyCZdKkqD/OtEafx/+YOUV3QIOFQGF9l6yq1FAP2W03paW
         7IOBjt/TtLr7pJu99N6ZyywMiAT9W12rJHPAEElk2a0O3REL6cBT5/7apyb315bviml1
         Ypz8sjF1Vpq4q+KZkGlS99SFGS3OtfglKRxA/z03Wk2x6CLX8Wzxk5xqqFY1RP/qnClL
         zDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716305696; x=1716910496;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmIG1ewdscO4XnDAwidD2SSCX9dExp3U4G4JfrJ/90w=;
        b=Ifwxq7cxVDEgmXXkxLsSIxU9I8cBJbCzeo4UIcpwGwwN2bFzsHxMxRI+DfCjihs30j
         E/HhPqvl+I517hgDxQ5+QkTCoDTE70ilszHekgabEsIapVdZ9Z5y0hqmYtC5tym6g2iw
         srK58/UPR2zr41ASzgZIlEBK7h1epiA/AHfnyJP1Ek7YIqz8LWvlW1JQTPf6LTDSvdAI
         9bMYxLBWEeZBzyWryE/pWobnkuc8jyPq90lrloQDY+jr6tkEQyFOlipJ3MZ6eYorciA2
         /EZXV5W/+3zcA7MEMrz/z3yMDHIyQ4tJiM+4fNTCfgPRhWJZTuQoc183uDQgJhYcqm+C
         C4gg==
X-Forwarded-Encrypted: i=1; AJvYcCUmlXGRV42KEJR0+vAEKzmkaeKnSspHLA7uYd0lbglnFzvRXzN6z+L+Mv8tXofG5Cfhnbn3PCH+ztoeTYWhlmZURDU8uNM0f1f7bGBP
X-Gm-Message-State: AOJu0YxKUwC9eK7ET5oURgmlxw+beMwiDjqh/OlHik1OXt34Lr+AcEbg
	4dU1mGKlejp5AB53SoG0IE7Pz3scZu1qTyqqAQz8z/oaCzezK8pj/eTl1bXr
X-Google-Smtp-Source: AGHT+IE5SbmyY8mDIdXP0efeg6mWZuRekNQNRFpmcwu+DiaAycjDLAQar08Kcrt5RLtjAul2R4KzUg==
X-Received: by 2002:a05:651c:d1:b0:2e0:c6ec:bcc1 with SMTP id 38308e7fff4ca-2e5204ac486mr192697861fa.45.1716305695558;
        Tue, 21 May 2024 08:34:55 -0700 (PDT)
Received: from [192.168.1.130] (51B6D146.unconfigured.pool.telekom.hu. [81.182.209.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42013c5fa61sm368737285e9.40.2024.05.21.08.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:34:55 -0700 (PDT)
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Subject: [PATCH 0/3] Add support for more stk3311 variant
Date: Tue, 21 May 2024 17:34:50 +0200
Message-Id: <20240521-stk3311-v1-0-07a4966b355a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABq/TGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyND3eKSbGNjQ0Ndo9RUs5SUxLQkS3MDJaDqgqLUtMwKsEnRsbW1ABS
 un/VZAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
X-Mailer: b4 0.13.0

This patch series remove probe failing when a compatible variant's chip id is not
defined in the driver like stk3311-a and make chip id additions easier.
It adds stk3311-a and stk3311-s34 chip ids.

I have tested stk3311-a in Xiaomi Redmi S2 (ysl) and Xiaom Redmi 5
(rosy),
it has 0x15 as chip id.

stk3311-s34 chip id comes from this thread it should be compatible with
this driver:
https://lore.kernel.org/linux-iio/20200703194406.110855-1-megous@megous.com/

Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
---
Barnabás Czémán (3):
      iio: light: stk3310: relax failure to match id
      iio: light: stk3310: make chip id check expandable
      iio: light: stk3310: support more stk3311 variants

 drivers/iio/light/stk3310.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)
---
base-commit: 124cfbcd6d185d4f50be02d5f5afe61578916773
change-id: 20240521-stk3311-2ee6ddafb970

Best regards,
-- 
Barnabás Czémán <trabarni@gmail.com>


