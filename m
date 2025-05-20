Return-Path: <linux-iio+bounces-19744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC71ABE3C0
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 21:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F16D4A7A00
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 19:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D35525B69D;
	Tue, 20 May 2025 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLpG4VNx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F32F1FDE19;
	Tue, 20 May 2025 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747769577; cv=none; b=NxdmNhLH0lgV6bEb+mkLUDqyHGnMnQr1IeKAxxJH+h77BfNc4+vgZyKqAoAT1tvgwrCMNlfBwK8P3V7N1mxN2myuYTrXcQtjzGspDPmr7Kn6uYL5xT+fZ7LRbCEDeFDHtzlfHZ/xsrEXS4KsrZ3HFBMo7rhTWVCo+aepeX/jRLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747769577; c=relaxed/simple;
	bh=DyY1sI3JCNQaoxUjUXWnrVZV3nJ3zWYHOEWyQDjkcxM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PwN0yknN5hBWTFA01qMeSodJYyTEg8fnBEq7yUlJ2qVxGb+2MjnFEAWtCvDGkL7hjjoz6h7TEmHAa7Wv9bnjeOk/sINl+FLphaShRIA6eGHVT5Biz4GhBkVG79RkvinA5VcgXUBKVU0hffjFTMjD2DCIgoH2o1ZIpE/jJB54WBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLpG4VNx; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7ab5705fafso738918276.3;
        Tue, 20 May 2025 12:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747769574; x=1748374374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MKP6+1oGcQmi64pHElG6X6g0bpuaSoRy90HYWIOpyos=;
        b=MLpG4VNxmjYaVnNWIBCQyoGO/zLfP3AIaXFaGJk59G7CHja4v6QrHQk7vEHoXbMbNs
         Vjk3GofMdzB34PPQNjdwpMROAzt/itpVextztl2FvVu4lX8DKpDSBJqbv4l9wosPUH2d
         xIQKd6PjAuCl3qTjxQIqd7J2fq5533HeX3iOk6WCdN/a9E55ELE9YScC6ZJ4H/WNfC8j
         52xX2rxE3oYLbh3J0qVtf3LdXaHkPKYWf5Oc7+v0LMEit7lXHgNhyojyz90At6oh+DMV
         Gk3MJAxhZnL60booyhKcTvqONib8czz5BFHlXuOu4TA9CJbjSXDznoOk176SoXknie+F
         Cc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747769574; x=1748374374;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MKP6+1oGcQmi64pHElG6X6g0bpuaSoRy90HYWIOpyos=;
        b=ZUKUeeUpVhoZeTzUkf9WYMfmHMfL/aDr3MpDvZ8ASubbghW59JmFWV81FR8WuH9WzL
         CMGf/wQdCmlZQlvdWqnjeKrpDtVN+5sGTXOkh8tspT2edCwobdfEcwstzqBFb2xsbGjT
         gP2rNzzqhbDEtKumXxyyGA5DXFTU45GIfGwTqEp776/HEsK3Fd873/gipDPX58+WqH0l
         Xc26dvc4uCbr7T1ql9CcynikeLMps3dhB3zUohFv7jFk8PZZAQlyrMfqE/A6irZoF9Fq
         jx1WsrdgIpaDp00oTqIlMNvilqe9jU7X2W3KZrSdIr20MePlT2pnm3Wb0iwfjOCKUAvb
         ztiA==
X-Forwarded-Encrypted: i=1; AJvYcCVl2ncmWetVhk6w1sq+4FRh8kScKoTJ/fyExCUQ0WO6kS3oGM3YOhisPSGLjwnrue6oLu5zI9yq8MDOiYSz@vger.kernel.org, AJvYcCWzQre8iu3VOWE4/bs4MKm2yrW2SCc9aX52z0Hdyk9dC3Wovs9kqv2ElKsh67tQU/HYdTR21EexLa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMT1NOEhf0gsoHJ77boeJZz+mEiQb/sF3WzKA3jVVico0CVzI
	IiA2p0tmK0Ssw+pFsUfDtHfcbYrjUJ5ZmjhAvRBnAGzT6gQIp1Qo1rrM/yF8FqETAjAZHKFwqgV
	nmZzeUlPI5qkkGxCQoQcvhUDT1Aez9Ng=
X-Gm-Gg: ASbGncvK/i3tVPekg+6FOXf5uAlTdV+AXZWu61f2ZTcDgJ1LLXhPlYtZhbqDBNEHRBu
	q6MB65czOduTiCWaMRTq/xQoPKAWhAozgFtlX2k2h2zOWb19iZxAEfk9LlzAUoSep9QVN6v5yL0
	3oFZQeN/W1Db5lrXXYFcqSrTz0gQosXfCXAY9w6P0zrBk=
X-Google-Smtp-Source: AGHT+IGJiEG8zJ/8kQF0sNzLIRKcYrQVfcThLoxYp2PsjAHiGu/ZkT83IPTm/EDO5QZHcDozPrCpRV3IlyrBYFpS8Es=
X-Received: by 2002:a05:690c:8001:b0:70c:b9c2:a966 with SMTP id
 00721157ae682-70cb9c2b5d8mr65319227b3.3.1747769574269; Tue, 20 May 2025
 12:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 20 May 2025 21:32:18 +0200
X-Gm-Features: AX0GCFvICKQf8CUfKFbX0hxnd25EN6iXvBHxrIc72rFEcfC2BMMS0gVdHSaZbgo
Message-ID: <CAFXKEHYe_LBV=95Rm75UXF97oUU5CTYzDdwXJZ=cr+4fGOf80g@mail.gmail.com>
Subject: Re: [PATCH v1 06/12] iio: accel: adxl313: prepare interrupt handling
To: andy@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, corbet@lwn.net, lucas.p.stankus@gmail.com, 
	lars@metafoo.de, Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lothar Rubusch <l.rubusch@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andy, I forgot to put my mail addresses as well. I copied your answer
now from the mailing list archive. Hence, sorry for the bad formatting
of this mail.

One question / remark down below.

> On Sun, May 18, 2025 at 11:13:15AM +0000, Lothar Rubusch wrote:
> > Evaluate the devicetree property for an optional interrupt line, and
> > configure the interrupt mapping accordingly. When no interrupt line
> > is defined in the devicetree, keep the FIFO in bypass mode as before.
>
> ...
>
> > +        ret = regmap_write(data->regmap, ADXL313_REG_INT_MAP, regval);
>
> Don't you want to use regmap_assign_bits() or something like this to have
> the above ternary be included?
>

Thank you so much. I guess this is a function I was looking for quite
a while and I
know several places where to use it.

Anyway, I saw, my hardware test setup still runs on an older kernel
w/o regmap_assign_bits().
So, I kindly liked to ask if you have any objections against leaving
regmap_write() for now? Actually I'd prefer first to see the
activity/inactivity stuff in, in case this will need some more
modifications and I need to verify them on hardware. I think, leaving
regmap_write() here would make that easier for this patch set. Please,
let me know?

I'm about to send a v2, for the follow up discussion.
Best,
L

> > +        if (ret)
> > +            return ret;
>

