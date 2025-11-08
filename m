Return-Path: <linux-iio+bounces-26049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9290C432B9
	for <lists+linux-iio@lfdr.de>; Sat, 08 Nov 2025 18:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A95644E71F6
	for <lists+linux-iio@lfdr.de>; Sat,  8 Nov 2025 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B213B263F54;
	Sat,  8 Nov 2025 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="viuk+q12"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B696523E34C
	for <linux-iio@vger.kernel.org>; Sat,  8 Nov 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762624513; cv=none; b=Soc7goRrldPbwjbhvssi0O1Mu0vC3oYPCDRxAifwZPHkxx7XFmzPVeyEQRG0KxjaBJMbOSysXJgxLv1V1qibbOR5M1FOSAoyvtIGfMPiKLw+1GTbPaes4K/LNoJVgKPr8FIra1FxUZ2d6lZgF/KIyvNlQuLZl0uXgirSRCIUiok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762624513; c=relaxed/simple;
	bh=k3Rd2Spgfzz89r7hRtjniFD7Bv4+K6aF4f38At+Vvq8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject; b=awXtoUwzyNOsSzOsBnQr3Kr3G7GC+uqJ3G9EIjjhWl1xQGW1B4V/ClcCvmGp2I3oWWO6/Q9o8CS79gFQe38HXQAsXJ2ZGw8Sj3AEo1c8s1ScwTn2kxCW8QMkHRtcfk2XHg1PQ5F+oYt9AS59YM5+/0hUCkQV4QKBnk3xJGMCyik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=viuk+q12; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7277324204so304102166b.0
        for <linux-iio@vger.kernel.org>; Sat, 08 Nov 2025 09:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1762624510; x=1763229310; darn=vger.kernel.org;
        h=subject:to:from:message-id:date:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k3Rd2Spgfzz89r7hRtjniFD7Bv4+K6aF4f38At+Vvq8=;
        b=viuk+q12cYzUO4OJtENxKqozl8pzSciZ5Xl7jIfwbGEi7ZtJ4YqXiM1Ez96R6Yx3/s
         ELbkhcsmHOHYTDPdfCP3ZDDKE+8KzlzGaecDru8jYhAAjMLhdJRbZ5aohu4Le3ZSMVkJ
         68OfpVCsQkwyC4uYlHspj/9D3Z3zfTT1gLMMz+7Ve1NBcXWGOFq62uxP9a8W+sHic2PB
         8lcuLC7JktlHVuo1ClfX2Rx/tdLi7hsx93ydD781upkEvLA0XNWYRt2mkJTuQpdj+hjA
         LeaD+Y2a1G0mjuonqKzXezmFcvDPYjBfK+nGosoh6s8qxYESsohBLVX29qlhm+mh/gnn
         Chjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762624510; x=1763229310;
        h=subject:to:from:message-id:date:content-transfer-encoding
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3Rd2Spgfzz89r7hRtjniFD7Bv4+K6aF4f38At+Vvq8=;
        b=NH7ZylDD9uhg9X8HhLUZBWNFrM1vEE80IEYNXx8IcCfQF15OAX+XR4jg/9xTlbA3ki
         qbFmva2ERi0jtFAeXWFMU0HgR5PGmfAW1tYEBM+0CsXmcFwpjrJKx70xkNK0+eTjOehy
         rP/HShr+xjybZS+IeyFFmZz6Rf/bCmfzXc7bgTeq1eKmHBCoevVURlHVLz5Kow8CacUH
         UsHarYRYAh23y8GqucvuxCPMXXBuv3BJU5IVCbOTAU/OnNPS7HXIuQNp+g3/mzrErjab
         gbEZtguVg6o+/uGd0lwz80P//VXHelRb1IXWbc85e9mlZLSo860wUs1vFtbo6ZGeenx3
         KPcA==
X-Forwarded-Encrypted: i=1; AJvYcCWYVCY7o1tlKgZq24U8iPrUaYxf1WBwOnqqT9j8+28TEHJD3DmZife7seBFZcE4yxa6nM3UIdtsUSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM8JFEsa5sISXgXVh0adk9yJDpaWlbDfHOE5Mz76BFqjZ+ldYn
	4d09EHkv2gTkg6ALsIqMSm86HRbY0XMxUQ4Xg2XWP+uUr0X+utrzLT+56B3A7XusKSg=
X-Gm-Gg: ASbGncu6jjMbbRCD09jv5cMrndsQKHY+mmxiKnwGMHadS7bWB0uf9SNFxXSXwhGCGPW
	RQHF4Pl76Kxu1wQIIn8cKIxPHjRExqzT7d0IfPvz7rELbhGmIvqklWDVawE898Idh60MrY8AAFY
	OHA7KHkgNMfEjrk5KCExXtamHwfasZHjBQwJc2AHSSf5Bgygv9+JqYV8BuoAEZRyDUiwKDiA+hs
	si5JJHDkUzqKC8DqHwpJ8pEcRGiIJ6vSdzGyIXfdzo3hVLw4xNE250RfO4/ZrM3dEun9zcDGdy5
	wEf0LkEk/5K02LvntNokYqYfisZCSqJPwj8VEDW9/adHTSjS64bjZhe5kHg2Cml379MdIl49351
	Kgg9WGHbhtqHtBH6cTMb+SpgWIii7sGnP2ChlBaAOnf7JXVt/90RCZabVhXStvt2Xpzkuf5fTPy
	w+AVrrUXWrB/y7lzo/UfAcjZc3zWpvqIU/1ac9BVYdgbzxNdL67Q6q4OJiLoJbWut5c8Ir/ASag
	YydY/1bvlMCKRg4DEE3hXjF
X-Google-Smtp-Source: AGHT+IHO/XSg1vNOl56IB1ngZ+T/41rI5MA8N+sLmeHNN0HtGXapUDDsZZNZHcSABN+1CQ4xrTQiag==
X-Received: by 2002:a17:907:5ca:b0:b4e:b7ee:deea with SMTP id a640c23a62f3a-b72e031ca37mr356826466b.27.1762624508997;
        Sat, 08 Nov 2025 09:55:08 -0800 (PST)
Received: from localhost (2001-1c00-3b8a-ea00-c4de-d39d-05f4-c77a.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b8a:ea00:c4de:d39d:5f4:c77a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf40768fsm584216966b.23.2025.11.08.09.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 09:55:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 08 Nov 2025 18:55:08 +0100
Message-Id: <DE3I8OHQQD0F.2VTQS2PET9MI0@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Documentation of iio_read_channel_processed return value
X-Mailer: aerc 0.21.0-0-g5549850facc2

Hi all,

I've noticed that the docstring in include/linux/iio/consumer.h for
iio_read_channel_processed (and likely some other functions in there) is
wrong because it's saying "Returns an error code or 0." while often it's
returning e.g. IIO_VAL_INT. In some code paths it's actually returning 0
but it seems in standard cases it's not.

Could the docstring please be updated so this is clear to users of this
function? I don't understand IIO well enough to confidently propose
changes there myself.

Thanks and kind regards
Luca

