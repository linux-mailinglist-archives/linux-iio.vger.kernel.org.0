Return-Path: <linux-iio+bounces-8110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 055599431E3
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 16:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF10D28715E
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536301AE875;
	Wed, 31 Jul 2024 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMTMrE3F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749A193079;
	Wed, 31 Jul 2024 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435625; cv=none; b=CCtoHwLhIky/rZYe4wJdOOWWZRlVaw0s2tnEFEuWZWsVwUPSPpNEkuGqyj1qymkGgJlixYp/s7iShUCYekDEGqsGJdPPr7NI1AirOxtG02Ba+Svf4Yc9KU64L4WnxVgBD1eutq8/l5tNgqPOawZb6LqcZjr/7suBB1z8iUL6SQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435625; c=relaxed/simple;
	bh=FgBETMnfB48dT/wLYRZDMPpRX1/Ps+MPcaDACxaPp/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn47K9KO+/h/jGhLqIW9gmvFae2UxFQi8VFy2vi7zW85nrFze1y3+I3W9GuBsdUbxFf2teO52chNnavie6O81cFRtOw9EvDmdVDY07Px+cLvN5RFpes+KcDYM9u/gWuUppE7xLZ9yHyqR0CgyoTf7TXrusXlT/ydx6tz5LhzQMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMTMrE3F; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc4fccdd78so40661445ad.2;
        Wed, 31 Jul 2024 07:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722435623; x=1723040423; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uw1THOXbTOFDexNRb9fnp+dVI7+0XGtcfzpjBj/YxcY=;
        b=PMTMrE3FHeEItK+mtEaF6TMvC+P4md+G5T8O9BiZ/Jn8TJMjKTMWHyNgE0qz9ayUHT
         uxZSxLL1xC0BJccCoAkpTfBk4ryCyxHoRJgT+AKhLhGkAUdtL6FxZEF+YQGloNMrbJI1
         Sx6UFz+T7ENPXnzSM9AXPA67UjmVlC8km5ogTUwUtv7+ahunnIWpIV7vJ1wmhmaPothJ
         DeEBwwvdn3sHx6HAvHPS9YOIhbaZFKCDtWej//iuFcT4oQryIHHzHq+fsNegfwdHHWK1
         BUcxfKKDVSko+c4sU32dSG00B4A6O+Mw7Jsq87h0B0lweRrJa6eAY3sph7F1Dpe6/1dE
         g+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722435623; x=1723040423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uw1THOXbTOFDexNRb9fnp+dVI7+0XGtcfzpjBj/YxcY=;
        b=bcjhE64e/hRpiEITkEBIJHMdVfX52It8i9gj0bLc+9oFG0ElbB4e5jf7hMZrRIcT97
         i6ChmRzKmYAqSLh+2K9yTsPX7wovgzRmwcTv6OLmwCLHYGe2HM2goatTuCrWqVCWnmau
         FZLHqU/nwS5qV3T7j2LCsC5MnQbhupatVWkxQgzWmArKB++WAZQPR3q5bkNzR+T6knsY
         Yck1yQqGIWyx0cq8/Hds9nQnO8d3vt9xKYScLzF1go/sifNi43fdBNlipa8SkC/AxVP0
         5YVj8okPdMTdh+dBi9yRkhxN5s3G4CaPbCfnJN4cAo+SrmBKh7ELq89sTixhBZFWrDlz
         07oQ==
X-Forwarded-Encrypted: i=1; AJvYcCViZDWUmmdpYja81CGix+L6xM+mdz01M9nQiC2VXil/qZMZFVAkYTLFuyV07EY+t6NhxbhmbuLi5WHIum5Dqa4NGLSkbnM6fbybXC84Qm4O7j6SYxio4oATmAB+ohfVaILltJmCE8M+
X-Gm-Message-State: AOJu0YyScpsaoxkFbVHmCfip1g+QxCQ4R2tgE3SWrGHitAQRDE28jYXi
	E88Ho/7+3o1ZorjOQLDNgr6Ajs/r5XbH2ok6dwHknKMJCLLRkr5m
X-Google-Smtp-Source: AGHT+IGVkeS1mYhhDeBXqjn+i0znnj8l7EMNV4/oVTC292vIFcl3BLHy6ZJObUPfDmjC5rlb5sSJjg==
X-Received: by 2002:a17:902:ecc7:b0:1fb:8a0e:76f9 with SMTP id d9443c01a7336-1ff04868db9mr129107295ad.39.1722435622643;
        Wed, 31 Jul 2024 07:20:22 -0700 (PDT)
Received: from joaog-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fc5e81sm120867425ad.278.2024.07.31.07.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 07:20:22 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:20:16 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iio: adc: ads1119: Fix IRQ flags
Message-ID: <20240731142016.6immldd7i4y7v2iw@joaog-nb>
References: <20240731140657.88265-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731140657.88265-1-francesco@dolcini.it>

On Wed, Jul 31, 2024 at 04:06:57PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Remove IRQF_TRIGGER_FALLING flag from irq request, this should come from
> the platform firmware and should not be hard-coded into the driver.
> 
> Add IRQF_ONESHOT flag to the irq request, the interrupt should not be
> re-activated in interrupt context, it should be done only after the
> device irq handler run.
>

Reviwed-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>

