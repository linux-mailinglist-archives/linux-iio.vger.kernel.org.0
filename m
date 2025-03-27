Return-Path: <linux-iio+bounces-17281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D802FA732AE
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 13:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03296173A7D
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784A2080CB;
	Thu, 27 Mar 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpAdgq0l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F822F2A;
	Thu, 27 Mar 2025 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080037; cv=none; b=SNAdRAJfL/+e1WF4dSR3auc6OCRruOUCMauJCYBhU/rU3Dnj75EARqtA/J6yyZ+tAsncN07V70txvAPAEZ/B4Wg0/9QgqQCCNxkNxpudYuvbBt4PXZ+wVDnqlQMvnxN+l9MF4iiNLIR9iTSovEwtM3dCfaVv3JLH/yCtXwAtrew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080037; c=relaxed/simple;
	bh=OyRxuRbuBHV8b3o0/C8mCF4e1TUCtATMDlYeAK82uTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2xLBEMNGgf6mqfcABQfZn5GajgbocuwHQ/5Wt1EtgNgS2xTAEr0UFEUTkS/PQCD+WnhDB6zU43RT4vfc2VvfZXgD52Wlt+DGmBKZ4Vu6buOtdiUZdZxNC+6hrNg41OiCjFj670cemn37XsuTmMmhAsS0Smy0Yu+3sDoDF6qoiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpAdgq0l; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so4081997a91.1;
        Thu, 27 Mar 2025 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743080035; x=1743684835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5ANoobHoDZEVP9qldav0lDqDxXbZjBZcAW871XBMXM=;
        b=JpAdgq0lCl6vKVnfyScWNoH53efLiWj97Gt5pmoSLnunAtYKax0sprZOC/wJytJ01O
         hSZ6OwptyhnfLafbREyaddkUEqCdTaByN8ASQCGdQc2bt3VwKl1eGHt5WrVkhVRfwKdv
         SybvQ9woyZoUPDEV1UM6/5x51fu0uwRDCVgfTriUf/QQDak2OBCyLzotcDsji27t1Szv
         qnmX+uJ4rM268bAJjsVzuEJIh7/T8WyDVF1DKvKuv5i+1gMbZgGQFJyu+kn+LE/80pCw
         opp3C+gzm61O8QxflsYoS3dltmEFqPnf/2xSdx/DOjXaHkjnYge8Rt6M3+AEAhiR6I31
         0eIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743080035; x=1743684835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5ANoobHoDZEVP9qldav0lDqDxXbZjBZcAW871XBMXM=;
        b=ZufRPs4s5HVbStuXA16Ct+EOKR9WJi5z7xLPysLzlvpNIGG7y9gFKo57kFHgqbJbWm
         HArn4PziKMpKdJyMZ3M8GBwc6TEgXj1YsHPdlX1QTc3BE5S9u7SiZh+flg0zjihvcjSA
         cEFyKhs6jNg63e3AjVhTIsK7m5lPUnoAWqkzCbYOCyC/zQg+7o3IMv+T8wTMgzTzhERL
         uomWNx5wzwOpsyLZW6E8hE6r6NGQKH9OMo6P9WJY1NN5KV/efdiwaD9X+iXi8rCx8tfn
         BPbvWkPDHF0kohNtaITabmvk5VHjSTGfGmeYt1p5TfPPGjzyskR/j4CDIUhAx7z2UfLp
         Ajnw==
X-Forwarded-Encrypted: i=1; AJvYcCVXxRKf8L0XbfwYBCxRV8+Nwe7G2UHDe0IqNT4swl6kSP/qQARiKx6f0WaMucbargWiTzmkLvNDprPYehmm@vger.kernel.org, AJvYcCW6pBNIR3EvvcRcq3X/MCfOtyJH4prSHhZVa4nZQHYUnKYJbc3vPF3v2zanboycapJEEhzaJr8h6mM=@vger.kernel.org, AJvYcCXr9Db1d169zmRULq16bTvdQP5EYV+eFnBQhhlh0FFd/VgNfMO1wYgJA0/go/EZ2RQC9uUfvXbD9K+D@vger.kernel.org
X-Gm-Message-State: AOJu0YzSC7Siw4SSm5aeapC9B9DOux8dykSKME2MRAb0xH3pa0bIHTcX
	c9FYOaDkmvVNrOi5p99+t2Fx5bbpu31llCOn9Qb4nwlgdqxKL617Y95wHPO+Wfc=
X-Gm-Gg: ASbGncskA2Og6NrrgR/8EnJbgQK5DZ14y7QYR6se/oBjVht1tcmBMjdyKR3jlOm2dYS
	0VuUg8TmDZuEproF0nVKtWAfToIE9Fa446sbychTHQJpPc8870TOxsCQFaujLCcrlwQ8oo+qfT9
	pAHOoqY9Mz+g/UAG/C+rHzeKzfCkqHi8ZjLcibc19W4Q98neCTQ4mvlP0Wjk2aUhPEnBvlwDl5T
	1U4BUeQ3kKJL9li3NgGUdGX18zffkfN57d/R2bddnoRLQvy+a47CnoaEB9x6P90dMTTpclzGN0Z
	pvm+jDFV2nX8Kw4CWnuGOYBPVQK/6ubI482KK094EcVodQvbHN2hUg==
X-Google-Smtp-Source: AGHT+IGjhVr6O2SlTvqKgsVrxF/ajlGqycQ2y9uDLDOtgp3ufhWNbAK1/lC/V40ITVpV2fLLH8Pqdg==
X-Received: by 2002:a17:90b:3cd0:b0:2ff:5267:e7da with SMTP id 98e67ed59e1d1-3050bcf1544mr59423a91.3.1743080035191;
        Thu, 27 Mar 2025 05:53:55 -0700 (PDT)
Received: from localhost ([2804:30c:b03:ee00:e0b8:a8b8:44aa:8d0b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3039e10b0d1sm2301777a91.22.2025.03.27.05.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 05:53:54 -0700 (PDT)
Date: Thu, 27 Mar 2025 09:54:56 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] docs: iio: add documentation for ad3552r driver
Message-ID: <Z-VKoNjmdQ5kdREF@debian-BULLSEYE-live-builder-AMD64>
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
 <20250321-wip-bl-ad3552r-fixes-v1-1-3c1aa249d163@baylibre.com>
 <Z-R_fiDpOqV6yXcd@debian-BULLSEYE-live-builder-AMD64>
 <uvpbdx7nzydkzigvtkx2loz2swkdrikgcbhgnlnwa3umk6ejk6@miwwdfqy3leu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uvpbdx7nzydkzigvtkx2loz2swkdrikgcbhgnlnwa3umk6ejk6@miwwdfqy3leu>

Hi Angelo,

On 03/27, Angelo Dureghello wrote:
> Hi Marcelo,
> 
> On 26.03.2025 19:28, Marcelo Schmitt wrote:
> > The doc seems to be all about the high-speed setup despite classical SPI support
> > being mentioned. It would be interesting to see how the regular SPI and hs
> > ad3552r IIO devices differ from each other (wiring connections, IIO device
> > interfaces (attributes, debug files, ...), any other relevant peculiarities).
> > Some comments about that inline.
> > 
> 
> had to add this file mainly to describe ramp generator usage.
> 
> The ad3552r (classic SPI) is quite old stuff, may work with whatever
> controller with classic simple SPI (SDI/SDO/S_CLK/CS) so no particular
> wiring diagram or explainations should be needed. 
> 
Okay, then maybe say so in the doc too. Otherwise this looks like a doc about
ad3552r driver that is said to support both SPI and hs SPI setups, but only
info about hs SPI is provided.

> > On 03/21, Angelo Dureghello wrote:
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > 
> > > Add documentation for ad3552r driver, needed to describe the high-speed
> > > driver debugfs attributes and shows how the user may use them.
> > > 
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---
...
> > > +High speed features
> > > +===================
> > > +
> > > +Device attributes
> > > +-----------------
> > This is only describing the debugfs file. What about also listing the usual
> > IIO device channels and attributes (out_voltageX_raw, out_voltageX_en, ...)?
> > 
> 
> they are already documented, since part of the iio stuff.
> Please see Documentation/ABI/testing/sysfs-bus-iio.

Agree, the sysfs interface we often refer to as device attributes is documented
in sysfs-bus-iio. Though, some of the docs for other IIO drivers complement the
ABI doc by elaborating on the regular sysfs interface they provide. If there
would be anything else to say about AD3552R interface, it could be added here.
Anyway, I think it's also fine to only have the debugfs if there is nothing
special about the other sysfs files.

Regards,
Marcelo

