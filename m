Return-Path: <linux-iio+bounces-9596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B361597933C
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 21:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F9B6B22CCF
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 19:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F347137747;
	Sat, 14 Sep 2024 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmfwg3YR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A182C7E;
	Sat, 14 Sep 2024 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726342589; cv=none; b=R7rk7d9b+E/lV6Pgu9UZjFJT5mWxb5B+UIvY+Z42rmHU5rNEY5sgM0XX9ekAQ97/+ZTZv7RU9Oy5v3JP7+J1MuBmk/6D7wIpEPiW/4wtjXsYiM69m7g0cY4AKohYkIvxFJXCCR982aKjQg00UfmqJ55O+ygfpCKGMqp35c6VvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726342589; c=relaxed/simple;
	bh=Aq0VPqO1An/naqvNFvCAB0TD+IiNrLVn9QDEvjABgao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSNsurXR5g2m4f1HY19PaGZLZFLGUKc2XlGolMJjYsBJx1bypfmhKtfTVlX8mpTXm5MXvmS8zNwxPCkTIcMgsJmIvUwrv9KiMXQEU2aAu9cNdx6fA8TY0q2pAuggJwMWoUEps6stoLFQbaMmbwEwMBz9jfJ1oYx2/s/RAJwXEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmfwg3YR; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a99fd4ea26so290975485a.1;
        Sat, 14 Sep 2024 12:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726342587; x=1726947387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ALsTYKzgGgZbnVn1tjPr9vM2XSHNkmqY0xXK29XlQso=;
        b=kmfwg3YRk5g13JvDxbtHWJr2r1+IMP54Mq8M2Hsmi/2aJl/L6pIqJEQcXWvX6xQ/oU
         yD5SKK6/cDAjrIHbBdzgyAQQ4NhWw8xP2rBCtF6STkgAmoFKMDyDIhFUjA2ISIfsOnYa
         G1qDJwBVDM7ccJ4D+U/qqsdoBYJbDSt6o3xbTLjs7fwKN8OQSasx2AnMiym6FyvszjmK
         4zidyTs9CG7BJrdxtY+vhWh2Rh8ygjcytvXjo1oDPiNqbbBYONQhJP0h5xeaEKW2TyPi
         4Fed/+veVn2QFqBwX0fzfNysvNhm7hqYeRodVyMUWt19cNPyCSUqtlyxmqg55H2Vuia9
         h2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726342587; x=1726947387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALsTYKzgGgZbnVn1tjPr9vM2XSHNkmqY0xXK29XlQso=;
        b=cJJqWvSmCicUaRHByowUlaGl6LOXsG4ob7taRVGDpcwSHiA/m7c07JE9VNPFDToUtO
         KimU+eb2c6i7A3cD4BdWDiVzE+4J2UsF/ytgEQOtCwabj7Y6RQA8smBwc9GlhR9nZWz6
         NQejN0lAkt/+JRO9favytNR2Q//ORzTamtbKZO6/4UhVZBCDZZRznDJLCK36bN1PLyCK
         gvL+QJwbKCYZ2Dsf93I7o1AXf7Kozi0a4HyJ+uNgzpquKJzCW75UOhboR5MOeiXY0J26
         vIdMMil6Stsz79Qgupdl9xqj1H1JRoK2tJNnaMM1PoE7LBsw/GQex4XY510mLAm2SqSi
         W42A==
X-Forwarded-Encrypted: i=1; AJvYcCVU33ff7T5ENG7KHSXxAFa4vYtKK7EbV/CBN6g5rVPy1V1VktU3AUOOOLxaxgOkamVPYAy77WcxrYh7@vger.kernel.org, AJvYcCVnuXJG6lJ0wbfkwy6d0ZfQLDgRzpLVl8iqLdvEB1Gv4G1B/x4LQYFRYORSLF1cETg6e6ekUDPm7/h6Q0H5@vger.kernel.org, AJvYcCWtTvQCQbPQOuz4D8KRun2elTw25gLxGxvBEmhI6QspjvsSPh4362khf33eGKCKi/wi8BeDeIUBAsnc@vger.kernel.org
X-Gm-Message-State: AOJu0YzXaVsFkOl47vahjXZA2FhiJUMt4VWwubYQqkoE9lXC2DNUmffo
	P55IF1wNIYReCDv9AyXnFi2qCk4OmIYunUUUiTvvnm3DmZbFmpt9ka53AU58
X-Google-Smtp-Source: AGHT+IFffaBty4kRKQuk9Dn8zTFyDBdZTKGT3Uez2+/aIcCrGmmqe2/FTKUXkL+bPOeDtJ3eut5MWg==
X-Received: by 2002:a05:620a:460c:b0:7a1:e0dc:ef99 with SMTP id af79cd13be357-7a9e5eff4eemr1715813685a.15.1726342587187;
        Sat, 14 Sep 2024 12:36:27 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c628f61sm9750286d6.15.2024.09.14.12.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 12:36:26 -0700 (PDT)
Date: Sat, 14 Sep 2024 15:36:24 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jagath Jog J <jagathjog1996@gmail.com>, Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	Nuno Sa <nuno.sa@analog.com>, linux-kernel-mentees@lists.linuxfoundation.org, 
	skhan@linuxfoundation.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: imu: Add i2c driver for bmi270 imu
Message-ID: <bppfwgxbc54jm6cmajgsqrmi25lxmfbsrrqrdvt3tispwl7erw@bb23iymteiry>
References: <20240912210749.3080157-1-lanzano.alex@gmail.com>
 <20240912210749.3080157-3-lanzano.alex@gmail.com>
 <20240914142734.4bcf14bc@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914142734.4bcf14bc@jic23-huawei>

On Sat, Sep 14, 2024 at 02:27:34PM GMT, Jonathan Cameron wrote:
> On Thu, 12 Sep 2024 17:07:19 -0400
> Alex Lanzano <lanzano.alex@gmail.com> wrote:
> 
> > Add initial i2c support for the Bosch BMI270 6-axis IMU.
> > Provides raw read access to acceleration and angle velocity measurements
> > via iio channels. Device configuration requires firmware provided by
> > Bosch and is requested and load from userspace.
> > 
> > Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> 
> Hi Alex,
> 
> A bunch of fairly minor stuff so I've just tweaked it whilst applying rather
> than wasting time on going around again.
> 
> I also changed a few line wraps to keep lines a bit shorter.
> Where it doesn't hurt readability 80 chars is still my preference for IIO.
> 
> The diff of the tweaks I made is as follows. Shout if I messed anything up!
> 

Looks good! I agree with all the changes. Thanks again for the review
and cleaning it up for me.

