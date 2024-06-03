Return-Path: <linux-iio+bounces-5718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFF58D8AE6
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 22:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F51287547
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 20:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A9013B2B2;
	Mon,  3 Jun 2024 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhNh8AA+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF5C20ED;
	Mon,  3 Jun 2024 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717446695; cv=none; b=PWSWmVlsjwOiIwi5R1p2NIaQW2IscMo32s79zG34QHn6zgMtyeou8mVt6s4R+fhD1Mw1wORW9eZ4FL+RrmpT8dUXX5agjOnZjnWlSbwM3dSBoLlGQOPX2wa0TTYSDEvdNkv9U4bqeseU4e1SaWat5Fd/YPqdosTSmgotxsLXgBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717446695; c=relaxed/simple;
	bh=XGZebBr8zCvaYXps87Qmd3fnl1MyeLFbm39QsPUIuwM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYPwBPeA5e5jYFBJOuM7HFuzwnCZZaMlh4FrL0piAzv8GQ96pLDJMqwWx1f8YAn7W+M4asW5r/DmAdPzyvaHS5BQHfSYg3EVYul/7M35E9hmUTIm5ISFHv1aFTeC8vb8XgK3Si2LMFArpUQYIogSFYb23zxIslxs9FqC6ZZxB68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhNh8AA+; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a683868f463so430015666b.0;
        Mon, 03 Jun 2024 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717446692; x=1718051492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=os+5Ay1w6RDLK6Vx4vHko46EFunkWDrbDUn4cogNNMo=;
        b=XhNh8AA+oVuRqfuafEeBmMEj9EVZ3tSwSmEe1A0wovT+CiVfjQuPgLJ13jrEFClFfZ
         Hsru7CmJwZeOlyjNXQCzQz1U6+v+b6ZFWzLy6i5zoR13xsE2A6tfvDPyLg+Ak9yJUQt1
         FlALXBCxrAE7YRvwUPkfPQBSLhNRtTjJNVpd28wJqJX2OsuJXZKIMo/EK8XUfYMEQzAy
         ADlwjeZ+z2tfcq8Lb416TsDrTBilW/AHzezxmBj5q8OFDev6Ev/+LHKCHP6n/KplXurJ
         6+DTR2S5cNddbHNffyM29K9xKCESmm6U7F7gUaBpBmTNfwrFh5mZ67QJMqRiN5Tzr7zj
         WxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717446692; x=1718051492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os+5Ay1w6RDLK6Vx4vHko46EFunkWDrbDUn4cogNNMo=;
        b=sibSwQGW2BxXF6jrVL7MH+Cf+70AqQk9ZqzsLBtA5SJLghVmIZZmYXMWxcUk97BU4q
         muBtjEoSpWf+slHv8J81n//5yJUrGQFRmMCNaejq6ZA04OJKV2NAVv8T38mEhZ6/YFuq
         tKLtwqVwsmP+0u/69iuo2ymJU+GJgbzstJn2mjwN8FYcqPVvlDMe9xV2dFr4WuILiDvn
         JdnHaSGV1Zu3gM7ZU6jltqpK+ZhPkx3hgKTWibCtE3TRAvQIM8jRjH0zlptjHw3UNzg1
         NfkOsqKhGJ8TD7vUsZpF9ZNZ992zC91IlFI7tRqRNXmXWkuX/ngQUO+CHpuB7OsOFYUN
         Ci9g==
X-Forwarded-Encrypted: i=1; AJvYcCXi4cK08VGLVKYk4bNEy/rOx/UqY/DbvvhgK6cJ4xIOhsMH0IGRFSGvbUF4zGJNhUsYwnKR09zxxicKfoxYyekVuwZtCWkHrUDs8ubyb+VcdJ1ao4kPSaisNsASZ2Jk1FZPaqCknZHe
X-Gm-Message-State: AOJu0YwPUvXT2zKELmK2WrX44SyV61LovmW2NQ0gA/0UBcOiKYLLpuRD
	6QMy3zq9tBiroFzoPOy0MD4G5WxQJieKhvfuN6WdIC7cBiSgQxNtSCCpZzgt
X-Google-Smtp-Source: AGHT+IFPElsFpULNKdVrsRwRpot93ZT9z82upFqNsvYWmP/+gwL3ha26WmOshKLWnSPvvJEbbaXJqA==
X-Received: by 2002:a17:907:119d:b0:a68:6c51:f571 with SMTP id a640c23a62f3a-a686c6138b0mr650695266b.74.1717446691867;
        Mon, 03 Jun 2024 13:31:31 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:c014:12e2:7350:b51b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68c5539b80sm362452266b.168.2024.06.03.13.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 13:31:31 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 3 Jun 2024 22:31:29 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/17] iio: chemical: bme680: Fix sensor data read
 operation
Message-ID: <20240603203129.GB444780@vamoiridPC>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
 <20240527183805.311501-5-vassilisamir@gmail.com>
 <20240602134106.2538471a@jic23-huawei>
 <20240602190015.GA387181@vamoiridPC>
 <20240603202303.0b1054a3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603202303.0b1054a3@jic23-huawei>

On Mon, Jun 03, 2024 at 08:23:03PM +0100, Jonathan Cameron wrote:
> 
> > > > +}
> > > > +
> > > > +static void bme680_wait_for_eoc(struct bme680_data *data)  
> > > Don't call it wait as that implies something is being checked.
> > > 
> > > bme680_conversion_sleep() or something like that.
> > >   
> > 
> > This sesnor has a sleep mode, so I think calling a function like that might
> > make it a bit confusing, since we are not putting the sensor into sleeping
> > mode but rather actually wait for the eoc.
> 
> Hmm. Bikesheding time. I don't like wait because it generally implies a
> condition check.
> 
> Maybe just go more explicit
> bme680_suspend_execution_until_conversion_done()
> bme680_suspend_execution_whilst_converting()
> or similar might be overkill but something along those lines.
> 
> The suspend execution terminology lifted from man usleep
> 

Well actually I realised that I can do some condition checks so I will resubmit
and we discuss again with the new feature.

Cheers,
Vasilis

> > 
> > > > +{
> > > > +	int wait_eoc = bme680_conversion_time_us(data->oversampling_temp +
> > > > +						 data->oversampling_press +
> > > > +						 data->oversampling_press,
> > > > +						 data->heater_dur);  

