Return-Path: <linux-iio+bounces-3551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 769B787D5A1
	for <lists+linux-iio@lfdr.de>; Fri, 15 Mar 2024 21:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75BF1C232E9
	for <lists+linux-iio@lfdr.de>; Fri, 15 Mar 2024 20:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D73855C05;
	Fri, 15 Mar 2024 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q41F+bjz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258D43AA9
	for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535755; cv=none; b=HGEsN0TohgL6HYFnIp0jhJsyNjIhxNLMBGMRnYAaBeTdla92OMfLH4lnvx6gzH0bCTmsRiFObUY35G4SOXEKjyR+5axCjJtLZpypUw7MiTPa/4/D6lu2r3q6fjGlgNmrpGc4MbdQBkRaA1UKQ2cWWaX/hjRko8nXRXIpMD4Zzeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535755; c=relaxed/simple;
	bh=HCR51LZGxY9u+LER+YX29PYsaXKpLOrG+UveZvoGffQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtpOVPBDaCQDCsDRYAKlRytxwoxIK5+yf1bUioO9Hucnt60XnSDUPFX355IJzEJanJZCh5+YY/gDBUjwIcyatXJ3EINt4S+NNisW8jiBxvzAqoR0etQRKH3+GHHKGy8Bxf2RtUxkPvlUZF9lGa7bzJbf5vFHDISiHeMmpGTgA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q41F+bjz; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6900f479e3cso23560536d6.0
        for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710535752; x=1711140552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8nC3IRvkg0kw+puOmU8y9gl/lCPJ97feO+tX0abDXfo=;
        b=Q41F+bjzmHmFqBnk2fSEp/z8QXX/lCQGxUlAHHN7Y5VJvennwGHQ9hKLnKk0EJhqEu
         VSe265rWQ62CNxe5kMDElZr4OGfP/WYapa+FEP6qxOTSKEeGsiwOew6hHqbnTQP5XwpE
         QrNiucGPtsZ6V4U2tp2/7Zeg34tHF5kZUcIZzwEw+Gq+4w7TcGCxC0Xv4ZQx/zFIiB/p
         SG4heGRyk6PB/pPSk9/D7X47fItgLUfB80mpb1p5xDCceXPCwyz4XBDChOn2flD4mwRi
         lu0xS2hCO/0QBMjYCbD9CWSYGyVG1t6FVQ54FSmfiZ1Rp9MEHWb+j41DudF16Ud1VOEc
         19fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710535752; x=1711140552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nC3IRvkg0kw+puOmU8y9gl/lCPJ97feO+tX0abDXfo=;
        b=sGngHmUS2syAhI69Xwp52UivkZqzdhg3V20LX7t4aTvriRvMsd+vKp3OFV7X303pwD
         wL9hbA9xnLiwX/OreYHq32qS168xEZhZN3wU8TzcZrsk5UPrF3TBi/W5Sy6VpabWBta1
         WzgmgPkUdFEsdvEqB3jmtp3nR5seLJF2cECVsgDYhQlXdZTmzDiLUhNUaKrvJt8ygeHy
         Dvo5s0b7y5CxbupoPcZOkp01xiSzmOgfNDXB47r4mG7BOH2qybXj00KITi5mhVGSqSL+
         BsamnoyqHdWx3xEtk8/u0Y3rqZlWtG/8271/1M1wB4A6i+/wP6jlCF5V/JtZ9BLIMJ2Z
         T4qA==
X-Forwarded-Encrypted: i=1; AJvYcCWNei7Cx9OovAY9B6cqxXwIPxei08y2Skw1mPwCXTs6SYFK11Z7Tq3vKrodMcG2ETiFQ8u8foQssrgl60FIUWJ5kYBjkrkba9Jo
X-Gm-Message-State: AOJu0YwGx1fuNP1LX0eCfJgXTRZZhGIClsY8oi0l9yZILQKrUa0404OP
	FdPd09YDSBb0pWdQH3mvDDrG0vhLZK4gJInJ2544IB0HUyOku9M=
X-Google-Smtp-Source: AGHT+IFkrtUF7lyLy5fVWY/yqZbS7nH0o8Cw9MJl+u02eud6tedUayIX4FS0j8Jg8xMUBKEkHQBPFg==
X-Received: by 2002:a05:6214:bc1:b0:690:4942:dd89 with SMTP id ff1-20020a0562140bc100b006904942dd89mr6052833qvb.28.1710535752677;
        Fri, 15 Mar 2024 13:49:12 -0700 (PDT)
Received: from cy-server ([2620:0:e00:550a:309:1e3b:44b7:197c])
        by smtp.gmail.com with ESMTPSA id kl13-20020a056214518d00b00690dcc7ae8dsm2366826qvb.3.2024.03.15.13.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 13:49:12 -0700 (PDT)
Date: Fri, 15 Mar 2024 15:49:10 -0500
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Fix the sorting functionality in
 iio_gts_build_avail_time_table
Message-ID: <ZfS0Rhk5WTJbwXU/@cy-server>
References: <ZfHM73ZqgnCp6CZv@cy-server>
 <a59061f8-5caa-43d4-bd4f-5ac4c39515ba@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59061f8-5caa-43d4-bd4f-5ac4c39515ba@gmail.com>

Hi Matti,

Thanks for your reply!

> I think the suggested-by tag is a bit of an overkill :) I don't feel
> like taking the credit - you spotted the problem and fixed it!

You did help me figure out the real issue here and how to fix it :)

> Do you think you could fix the removal of the duplicates too?

Sure, I can help to implement the deduplication logic.
Here is a potential patch for it based on your help.
Besides, I changed the stop condition in the inner loop to `j < idx`
since the current last index should be `idx - 1`.
---
diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index 7653261d2dc2..32f0635ffc18 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -375,17 +375,20 @@ static int iio_gts_build_avail_time_table(struct iio_gts *gts)
 	for (i = gts->num_itime - 1; i >= 0; i--) {
 		int new = gts->itime_table[i].time_us;
 
-		if (times[idx] < new) {
+		if (idx == 0 || times[idx - 1] < new) {
 			times[idx++] = new;
 			continue;
 		}
 
-		for (j = 0; j <= idx; j++) {
+		for (j = 0; j < idx; j++) {
+			if (times[j] == new)
+				break;
 			if (times[j] > new) {
 				memmove(&times[j + 1], &times[j],
 					(idx - j) * sizeof(int));
 				times[j] = new;
 				idx++;
+				break;
 			}
 		}
 	}


