Return-Path: <linux-iio+bounces-18607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2003A9BAD0
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 00:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084411BA61C7
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 22:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E53F28B4F0;
	Thu, 24 Apr 2025 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNnPsaXH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CFA1F8730;
	Thu, 24 Apr 2025 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745534087; cv=none; b=QgkSfEGyf1MaGZCRptESQ4XmjRF4OnfxdDm0vITAycVC+xsdQAD5SRVONsLjter5Y2yv8cr+3XHO3RLIXhheleVzoozdbepzzXRM8F3SUkg6a0NYzWFAVVXYa5QlFi8wQkiHimd35PWg9+uRgXg+Bzp3DWQEQo5+49n/2zOfKI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745534087; c=relaxed/simple;
	bh=SMPrGfr8bTytlLMThME5gZ5a9KglEcvzpXeHtz7Oluc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3ca4SFyrMopijwN6vkkQOkl3p/T0Jxl3uucRiFyaMK0eh2TpiTesTBH+EiIq42BMvvN8SVvksvBpIqytrX3NGNVLldhYUfst+dM9B43o/gJADxwwveaOkVdM+0y0a05g5Fp6iezYokBi5ilPovgf+whra+w6zqjjnNc99rW1yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNnPsaXH; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c542ffec37so173913585a.2;
        Thu, 24 Apr 2025 15:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745534084; x=1746138884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmKYu+cBYor5ouArn8J8SGEMb8V+WtQZCe4d7Eom8vw=;
        b=kNnPsaXH0lTLSaUcxl12gxFlxRsVd5XHXtVc8TA235ebYNfzYReVQOQua2nCjsL7J7
         bBY4K1nCrbT+Uy+J2ohXusKAtT73hesfYjmrp1SNfF3oxV3nOANy7iZ3K4aq52qxTF7Y
         AqcOi9ZPJEqyqGiQaJAC9Bs2JWx2LUggxqVuwRzRJny5nXVTQ/4UXj9fGDcoTl8PlK5U
         e2pF8t8r46QLQ162Y7JrkhKjQda0zauEjMX/ppsTeKCyuVy89ok7y8+3Udqszt/bML1T
         KCz6VOItL65yOC7JMtF47JcYsnTr7hjqvLiuVRA2Uv2dN0aK0dFcvUpA6k0y3O0a1jRX
         3oEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745534084; x=1746138884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmKYu+cBYor5ouArn8J8SGEMb8V+WtQZCe4d7Eom8vw=;
        b=cpX0DlpFqxro7kHCU29ghpKXIkcB8hB5tV1/T6eapM4IeX2FfcGxwAASzBFTVgVgYi
         bH7dJ/wp7gcGdLeq+uNY+tlMUy+jJti4hQ47w/z80KWTkT33ocUWl9RQPMs5XC/DgOhM
         j0aGNJvExdXgEamPbsGKoXVQb4wNsqRr34OkcY8BJDjniN5BUrVpelAcZgG4k5QfwGn/
         pWvbzCXlhKVSPOCBwyn28neBDmzL1JdE8MTa7Z1DsDGvHiBy/FitVtf66+F/VyBJDDZF
         cyjsFUdBU69liLUgP40szM7G/Et3UISFJ8P/SoaHv3syNZ8iV8QqNGUfg1vv7skBiJOc
         7kYg==
X-Forwarded-Encrypted: i=1; AJvYcCUiNt13cGXTdiRuNHsCgudx9sCed/BSRkiJt/OMvPiqj67kNvSL4gkUKWOZlAL33lQv6OKorLi4gDo=@vger.kernel.org, AJvYcCVkSG8AZ1QO8XYJmwo9ayT7ySMa0471zX5d8ON7e7kBXhAkJEjvLVuhabAlvDJlC1hRcQnSkKfG@vger.kernel.org, AJvYcCW72qw8pdXP1/OwdyKDLZsm3wI+mQ3V+FIqs05Q4M0W7rHvZ2e8u1xkQrb+pEs4hVpY5/yvw1oUtlqxI2iD@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc2tFXk/X8cGx1WZ/jFp8JDIEa/yfSdykyR5qh0nRsMYqi5sQc
	CwRUGAT6d4Jgh9tG1lELK4sDzFmq+3cYDGvvwv4HEqfjAXVuvgAV
X-Gm-Gg: ASbGncs56Ey32oNTHqL29bXi+4B36eaJDIbhoIa9TUPAKRpjnKHVa57oiTIp5nnlXE+
	rozTiLy5qUy3IlhxT06q0TjLbTRYl8yYTyF576sGZpruc2627ad0EvVvTXvwnnp1XdHoCvO7Ibe
	7sBYVsrBZWMqEP0LFInyiQVfp0PMYZ5Cfk46NTDQdXsmWKWwyJc9THzyGYb70QHzEcne92vJ+gS
	qu4Gx4O34z1+sNNPVJ67729PmYRQ3i6s++9/I9i618TZbs3LxJ5lXqlX71Oq5H2NsmvMIJoaaqR
	bJoh9K6zfXeF+eyLiXL20tHfbacnBR64nzRvZpBQirYejU2LN3WJjM4NtWrEjbI2G/7Ef7/VLp6
	f/FZEUDsleH09NFtb85k=
X-Google-Smtp-Source: AGHT+IFhWfpPaS+f5kQCG5DZsx23khz4dr2xWW/RmE/a5uwOzL06L/7GyubItr+3lo8EJrtTepz09Q==
X-Received: by 2002:a05:620a:45a3:b0:7c5:4caa:21af with SMTP id af79cd13be357-7c9607ac638mr39876985a.53.1745534083903;
        Thu, 24 Apr 2025 15:34:43 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958ea36eesm142986885a.111.2025.04.24.15.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:34:43 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: andy@kernel.org,
	dlechner@baylibre.com,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] staging: iio: frequency: ad9832: Use SLEEP bit instead of RESET to disable output
Date: Thu, 24 Apr 2025 18:32:08 -0400
Message-ID: <20250424223210.91317-2-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424223210.91317-1-gshahrouzi@gmail.com>
References: <20250424223210.91317-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the AD9832 datasheet (Table 10, D12 description), setting
the RESET bit forces the phase accumulator to zero, which corresponds to
a full-scale DC output, rather than disabling the output signal.

The correct way to disable the output and enter a low-power state is to
set the AD9832_SLEEP bit (Table 10, D13 description), which powers down
the internal DAC current sources and disables internal clocks.

Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
v3 -> v4:
	- Rebase changes ontop of most recent changes.
v2 -> v3:
v1 -> v2:
---
 drivers/staging/iio/frequency/ad9832.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 49388da5a684a..2e555084ff98a 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -236,7 +236,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		if (val)
 			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP | AD9832_CLR);
 		else
-			st->ctrl_src |= FIELD_PREP(AD9832_RESET, 1);
+			st->ctrl_src |= FIELD_PREP(AD9832_SLEEP, 1);
 
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
 						  st->ctrl_src);
-- 
2.43.0


