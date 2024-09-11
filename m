Return-Path: <linux-iio+bounces-9444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A77A9752A1
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 14:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9F51C26640
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6190E190671;
	Wed, 11 Sep 2024 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meGsVCPN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7589154C0B;
	Wed, 11 Sep 2024 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058297; cv=none; b=kw2YWlf+h5FZF0P8TTb0z/XXDVLwFJirUdInG0nSNFpYVujrtw/ZmePV5sbLBOiwOtynEsUaSxDSviaxiIyN4/bJNqmQNuZWOKTvexcHSvq4YPbGdzY/eud7iIp2jtgIKLQQFFAX/TapvndXDQEDgQXOpOEV0QedpBxtr+RZ5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058297; c=relaxed/simple;
	bh=ErB7k+owsapqZOqYElNaW9OC2HT524c1l5alZXyfx2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0rBUGXGqvvs/72tGbUn2IPDnueYS9Gk6pe/VRjloaBiAvXqs/8dwugbhEThy+vEANhNTjlkET1ElRx1p7VK7Y/w7eztqh//YalzhH+UIXsBwAqr06hoiN2iFO/8geqczUF6UA02wA0BTyOUmWwfssd5UdOrK97yJVu/WY4uNG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meGsVCPN; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c35357cdacso41673176d6.0;
        Wed, 11 Sep 2024 05:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726058295; x=1726663095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJdkhwtpSR/xetmtoOM5xaNPmMk/QvQ0r1VyhnokH14=;
        b=meGsVCPNF2ShyJ4OyR7SPqeVmQKxkX7C5up3syTIyawtqsw8qMwO5MjJVFDH5KtEjU
         mry+RlxWEWYbE6DFlC+ETimU9E52Ip9E0P1DxQbftZRGnnwUAufOUy9m3OVFwer7P7Fw
         BDGasZlM4uuXv//oLYqZQf2FEEP3k8pnDo9bJIJIIncWZic0HOCYogdphjNHfJyHBjtB
         57XSWYGQSKZQAeuqX+TtX92mwtrDjuk9rW8pGCUgKJre9g5vo6/vdlLQgapbU3/k4SB0
         dShkMh8DK20G+37yrM90nTiCe0j5orO4csOaiCHL6PmkV9yKT1iJI3Uh//euOBUR449P
         MHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726058295; x=1726663095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJdkhwtpSR/xetmtoOM5xaNPmMk/QvQ0r1VyhnokH14=;
        b=qrQVpASLeBN5htl9AcgXfCYc2N9s4h0werrTtW6EYHyPV37aFsYLf6Y6Y2g9dRlNFU
         FB+9gU5PWhrfq24P/4/xbod5hoze0qsjjetAQcoss1HSFSU9XYlItd+Cz1uR0as+KzNH
         W7o6ZUSJCAnbOMxnnFUiO0vQywaA4JrUcrbg3NED7TKy4j8zyhf2uFomow5yJB+xAzJl
         lWk6m1zt0jeIcFd4UqZHrDNvMWmkoBNsv/kyMejFnYnJfMogq6AhCaVca2CBR7tW9dOl
         t5LA8E1l7pEqfpaqaciRy2zARUVUKkAsKWcW4j7mDVNFdR4BN+IPJi+QUj+XyFDZOoY9
         xOaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4iO8hg2EtCUUHXhWgPbAzeoeyCdw6DkNTr4auMiAN0och63f3AyzWjzmFGte7wuTZTXI9uM/6xx3PzauQ@vger.kernel.org, AJvYcCVK4J0TwhPg4sYUodsOFUITjExoeYbhg//ZopRzpqSynnJmaOts6USO9Nz+2Csa3GaK3efGevuxK3uc@vger.kernel.org, AJvYcCX+buD3cm3mXXes5Gs1gWNN4prLPyXtxFgGhjFdd+55yAQCeuUKBvV9x3/QK95ZKpnp60biflcrX27G@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5+592tCXmKpjU0SbitsKkHgrwMtn4NLnXY4wLrTm9lIRzrRld
	Fcyg/5jjRyivNJAmN99YqaQ3mjWeSh1j5sINrXGu/hSeb0ad8kSR
X-Google-Smtp-Source: AGHT+IGgwwN2WPLqtEao6Nlv2i1oUDa7B4fXEZVM/Cl4rAcFfeWhaK2jO9k0MI+elEb8wQZFNTY8wA==
X-Received: by 2002:a05:6214:1406:b0:6c3:665e:a1fa with SMTP id 6a1803df08f44-6c5282fe6damr257541076d6.11.1726058294500;
        Wed, 11 Sep 2024 05:38:14 -0700 (PDT)
Received: from VM-Arch (191.sub-174-193-8.myvzw.com. [174.193.8.191])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53432dee3sm41578346d6.8.2024.09.11.05.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 05:38:13 -0700 (PDT)
Date: Wed, 11 Sep 2024 08:38:05 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Jonathan.Cameron@huawei.com, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, jagathjog1996@gmail.com, jic23@kernel.org, krzk+dt@kernel.org, 
	lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nuno.sa@analog.com, ramona.bolboaca13@gmail.com, robh@kernel.org, 
	skhan@linuxfoundation.org
Subject: Re: [PATCH v3 0/2] Add I2C driver for Bosch BMI270 IMU
Message-ID: <6e6urdzq5hf6n2ibfxs25b6hi5yccpl35g3neuqwj5ijolonhp@23vgf23pqj7x>
References: <20240909043254.611589-1-lanzano.alex@gmail.com>
 <20240910222254.14281-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910222254.14281-1-vassilisamir@gmail.com>

On Wed, Sep 11, 2024 at 12:22:54AM GMT, Vasileios Amoiridis wrote:
> Hi Alex!
> 
> I recently received a review for the code for the BMP280 sensors, and I think
> it applies well to you as well. Since you are using the sleeping functions in
> your code, maybe a comment on top that explains why this value or where you
> found it in the datasheet would be helpful.
> 
> Specifically for the Bosch Sensors, because Bosch's datasheets have either
> hidden or no information at all, and you need to search for stuff in the
> respective C sensor API in the Bosch GitHub.

Thanks for the review! I'll be sure to comment the sleeping functions.

Best regards,
Alex

