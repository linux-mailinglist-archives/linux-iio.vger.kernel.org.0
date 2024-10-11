Return-Path: <linux-iio+bounces-10471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3248299AB9B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 20:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91AC1F21EC6
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8AE1C9EAF;
	Fri, 11 Oct 2024 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZGz8Ctu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2E7868B;
	Fri, 11 Oct 2024 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672706; cv=none; b=u5Bx8HsuuU7iR1LAgQXYWe4GCrWogHCdqY+4WddCQV/XQQ9LfhStVaOL5fOz02/KopDgUblw50yKLGN1GgY3srtsNiOWDM7BFSoR8mhXnGQrpINW+sqEWpDRCtRVrMmSxBBU9F2EHrMWkft7TAthneg/3fMOzEajvMhMd2eKQN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672706; c=relaxed/simple;
	bh=yRPVm/DBJkK5IiDZ9InjezCVxKSjpxkg5OZcFNpujqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJCJAbDYhN+cCPOohgrGJyok8lW6zQAtqPl/Scl3xqx738gPDfoJpGakdOh3j4r4A6RRMj3FDN6TrMxK1JV1Ml8aXPS5vB+ENLLFcqIMLco8KBW48G1AAQ6B4/6ZfZ6CSaacyE6tnrfXbqTp76VCFxvvdPRthwWrriGtyA/2708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZGz8Ctu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so1242113f8f.1;
        Fri, 11 Oct 2024 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728672704; x=1729277504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yy525F7nihGZPfJhxLTeC5sFotLGbMo0KiOUutsPUCc=;
        b=TZGz8CtuK4uXtYtBsrAaMlzb9RFKDuEvO/Uu2NUNULki5bK4HPmL3yvNNNOckXVTKS
         +qx23SYMXYF9jtfkx7O2jlFHZya9BJzDqJw/Fb3lyV60SCCnPlPtCynjlQQsDAVnYhsw
         9E2qoQGagqfVkRTR7bL8yI5fkX/pZ6xkPqBWja95OnJkpvgNvSt+naGOeok/pWQND6Td
         DUcFnIDzMFZqHFwuY6OZrMIkmW8DEeIjCiXDxc4pyc95mvIXmVKpQaY9qv5JZ7YUk3cP
         xrpZdkDOm2Ua1W8pi43zMwvqc1wFbPREG1C6F/hqRPRrnKQM1zEFlCZZ8OluR0S5znuM
         QXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672704; x=1729277504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy525F7nihGZPfJhxLTeC5sFotLGbMo0KiOUutsPUCc=;
        b=b0f5tS1nLq41q60oFAph5Zih8WrDRidyaOJOVypRa/Ulaf9KRgEDBBa3Kp7CvLyr1o
         FCEVx24jrLSYKhYZNik4I+jHQk0gtoc230xj/N+F52TsQL4Cm+9hg2KFXVqW/ZiBppre
         C2Xzfhu3Ay6Wq9ws7AvuX/ATIgPJEZiMI6831tT8hgu/OPGJMjJQjtj1ms8Qav7E9a/p
         eTwV1B3Sq+QGJnaMSi+N2Xg0w8N711kqBDbq/sdIPvkJ9e4v66zC6j8OpbGNlQ4f8fCq
         VW+z5qFSYLOOweyXc9ZxTSY6aFZ6JfLS47rfewlHFq0P3vudY8AorRFfx6LfDDyVQHX9
         vnjA==
X-Forwarded-Encrypted: i=1; AJvYcCUNtR1sR1WyNYthghvh0Tpa3NxwIQ1erM/T2RNcohxU1QzBoKk2KVV7w/HDUOFj04f9I3AqrKKwgJUZ@vger.kernel.org, AJvYcCUu0sciNHUeDZZKHlRAoSaK6Ew0spXIHYej0c4RO+e0ylQndMCXjzZxVyIzI/WDgAqp3o2aFlf9ArEC@vger.kernel.org, AJvYcCWAbRKd2XmR167YObmRRrQHM6oalKztq4cOnwI5K52GpOiLtULJ5xxADHtnHonWUeHsJKdSIPygn+e2gidK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5kuK+TFqBAjtKcfdrh9ZCEwA6kIsEuuZ3ttABisVAE8EylUS+
	GxVqrp31SprcOeHNuAM1eBhyYiucvvK1EfladZ4h148ezn3LWywL
X-Google-Smtp-Source: AGHT+IHPfkGYWuvscaXOfgQ1QfkI0s0Afa29sBrJujTl5Dr6EwNjdFVVlxmQzBEUFPfpaDvzC7D0YA==
X-Received: by 2002:a5d:40c1:0:b0:374:c614:73df with SMTP id ffacd0b85a97d-37d552a3962mr2325806f8f.57.1728672703537;
        Fri, 11 Oct 2024 11:51:43 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:73c8:39ee:29b7:ae8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8ba1sm4527905f8f.23.2024.10.11.11.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:51:43 -0700 (PDT)
Date: Fri, 11 Oct 2024 20:51:41 +0200
From: Vasileios Aoiridis <vassilisamir@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/13] iio: chemical: bme680: fix startup time
Message-ID: <ZwlzvboBPppQMEB_@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-4-vassilisamir@gmail.com>
 <Zwj3V1oaTO6je-w9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwj3V1oaTO6je-w9@smile.fi.intel.com>

On Fri, Oct 11, 2024 at 01:00:55PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 10, 2024 at 11:00:20PM +0200, vamoirid wrote:
> > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > 
> > According to datasheet's Section 1.1, Table 1, the startup time for the
> > device is 2ms and not 5ms.
> 
> Fixes tag?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

Hi Andy,

It is not affecting at all the operation of the driver so I was not sure
if it was worth it to be backported to the previous versions. This is
why I didn't put a fixes tag. You think for such a fix is necessary?

Cheers,
Vasilis

