Return-Path: <linux-iio+bounces-21927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F54B0FA28
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 20:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF46E3BB95D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9330226D00;
	Wed, 23 Jul 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ3HRXBd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9C0218584;
	Wed, 23 Jul 2025 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294859; cv=none; b=HGe3ObMkJ4ilCKYRiiJuxcJ6VDNs0n5HsGq49fddTGJMfjd59SXnbNrMAR2T7LHsYE/3YoJ4u+UXtIYJoEUzG66yPRx9Yjczvh8fB9KLMYHY8/ihJv07iTODgCu4yYrYKTFyJygntr71oQRjGkU92ELSN++htFcsnz4c1leg6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294859; c=relaxed/simple;
	bh=y8ndKAU0XELkdLSclxK3ATxEFZFCxeeOV9leOVwVxzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2ybiKJfecYOX9G0YZUdssLmNgtn8DJn8K4OZDVXyaMat0MQXYUZd3FTtsMil3G7KgTCb4ACBfAXZiaO1kH312ij/Slq7v8+BW4a3f+EXsjphMWBTIUwSsj6DLAgnvOWjib2I4TsbOg2vDMKf291gWAlI2wZmkxaCU65pZ7l/HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZ3HRXBd; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b595891d2so955381fa.2;
        Wed, 23 Jul 2025 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753294856; x=1753899656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Axr3ScreRJPvzv1O4RqP7gSUqepQ7bVpxDj875t7GQ=;
        b=UZ3HRXBd8izLVTWsmwkbxt9VHVSJIo8ODgUBF4Z1m5BQcLoip5E1Pp/dYMCzEZafSz
         ruIzcenYREKy5yLCXVARDZJH0UeAJN6Az6OwT4ThjHiEXCeE7Ob2PG1d6NOx8hCW7N/C
         fxy7CvBta1O1nceKB9X1UMQNGLQ1iyDHQ0A0/DJ7jqT8oqjF6JV3eqxPZmoSSdcmeBpC
         WZDIvlW8j5pSWVudLr8XgcsqQerGSTFMvwz8vJjG63gUBaXZtLM4FaKm3X4aZ4S5ijHW
         Sqz3yLTD0muUQmVDjfX4bR5owwz5o2Pjjpo80bIFCpPhzi003/sdabAUv5hGWChuyi/v
         X95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753294856; x=1753899656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Axr3ScreRJPvzv1O4RqP7gSUqepQ7bVpxDj875t7GQ=;
        b=fXXsMYLGfAYKlKbGMJini6kUGkycmbkAbZfdn7sEemLGO7j8J1t7iQOtzesRIFYydl
         1dXAA/ato2f+7gnA77GFGMT+ou2P4UPFa/yggFkdzFyycXgMw0RpwrKJ0WSxNIPWV5Y0
         ESv9Q2UdvAaFtEIMmF4/y4vGz1opIRYgOQywchoZdQqHChbBqN5/P/DRzXVW1ZpAawkD
         SPj29m1EwKgpslHnjvQRgGmn/Nx6o679ggB9inuqtnw/CrTesuOf3mKUNMpdngUqeVDp
         dz5cCmfsYMe/iPOnt5HwVAV4AgDy7pbErnGdnGth6KpFu35GU4n4XCq+8X2bQW+jrTv6
         RqPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGH989J66OLTxmsQsaWbRaksYCa848uujSx+z5rPK8NLsT0sYZydV0gX+0SWYak1aXVyaXG2CUsirBCgQM@vger.kernel.org, AJvYcCX4z8fbvjly3ljeQ7LOHCNtVDRzcBkIQ0lLNuX2k2M1hwMPNKW/Lb0p1UOntJaDD8ROiKxxxEtbAgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMBSJPg8gbPrj9qnVTWRcMhJYPVfZ3avCDwWJlvq8+8NjjlspM
	I57cmajG43XmUhWb8+KYdhBQzRGRNZsaufoh+9RG78KH4gVwO7OmQI/og91HMmz488qt4JqPatY
	HAdS6EtelKwcSf8cyFt8oc0TmTMU0DSc=
X-Gm-Gg: ASbGnct/weVCaw+R6vjyX//oAEohWlf0ijdWdIGXLn/cvHwTqJIGfFV5NcgKmLRIOys
	jGdknVQ+RBDkdmy0AxSVc580iR3iTs40iEImVuUXgu1HDiFlmHrrdOIzMH14KPC9+tAFP6+PlxV
	at1IpNrDxKsYUfVa3mos9PYcyN4itMU1Vcd7F0TyLJiyjWt5uOiSAZhGOClg5oofTb1VkTsqwSN
	fn6sl6doxAmhJTldFs/nqt7bEm57oR9VHmiPfniESfwAE/JrjY=
X-Google-Smtp-Source: AGHT+IF0m6GXx5ZuRiSeiWPR60TeQ4GID+myFEnGmGz9PFWMWsmcmX2U8y6ld5ZoEYgW4LzmJ4n3W2M9wEip2VuB3Xc=
X-Received: by 2002:a2e:984c:0:b0:32b:7cdb:aa4d with SMTP id
 38308e7fff4ca-330dfe21d26mr9486151fa.31.1753294855755; Wed, 23 Jul 2025
 11:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723114645.596648-1-akshayaj.lkd@gmail.com>
 <4cb1a608-a069-450c-8962-7966259d97a8@baylibre.com> <20250723164620.5ed508f9@jic23-huawei>
In-Reply-To: <20250723164620.5ed508f9@jic23-huawei>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Wed, 23 Jul 2025 23:50:44 +0530
X-Gm-Features: Ac12FXw64U8g8rRsuA-03ruh7TqKxHK2rNFY2e10jxDcDlCyMYLMjX1GkLCx3AY
Message-ID: <CAE3SzaSdS0pK1jA8y4WEd2ZJJfTM460j2qny1i+9pJcoc4nQ1w@mail.gmail.com>
Subject: Re: [PATCH] iio: light: ltr390: Add debugfs register access support
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, anshulusr@gmail.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Reviewers/Maintainers,

Thank you for your valuable feedback.
I truly appreciate the time and effort you took to review the patch
and share your insights. All the feedback cut the overall changes by
approx 30 lines.

I have sent a V2 patch with the following changes, which is in line
with all the feedback received.

Changes since v1:
- Replaced _[0|1|2] macros with a respective common parameterized macro.
- Retained base macros to avoid churn.
- Swapped regmap_write with regmap_read to avoid negate operator.
- Simplified debugfs function by directly returning return value of
  regmap_[read|write].
- Replaced [readable|writeable]_reg with regmap ranges by using
  [rd|wr]_table property of regmap_config.

Jonathan,
Usage of ranges in switch/case was really amusing and a new learning
for me (never used it), but I felt using rd_table/wr_table
is a much cleaner way to use register ranges while checking read/write
register availability, which is fundamentally similar to
what you suggested. Hence implemented [rd|wr]_table.

Kindly provide feedback on the updated patch as per your convenience.

Thanks,
Akshay

