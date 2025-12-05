Return-Path: <linux-iio+bounces-26789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53475CA790F
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 13:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43B7C3065E2A
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 12:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F360032D0C4;
	Fri,  5 Dec 2025 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDb7a5Nd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F6C3148D7
	for <linux-iio@vger.kernel.org>; Fri,  5 Dec 2025 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764937835; cv=none; b=feaj/x0ToctHCkQjcdNa68tZ6p1rB3aFkiJmTuxmZkWVYZVIc+s4pZxt/WbBj4VOpzF7d6c1NNW8JFQztOnUlkTUwhqyyX9VoiKbAEK4C83FEKhnRddAcJ85TmyyKdhzwzkUR4hy+LvMlquhqCWN3QtQMqX43fd1icC8aVL++CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764937835; c=relaxed/simple;
	bh=4mbe29jPvHe5+nxFoC4URBIJzmlwrissieRk78dV2aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAu2p1TrsiaFnFcLUb7DEDqMtOWGnFyYDrp45/LpgJflEU86iG1u6pXw+1j6G8az+0gyb5WvPHOAvD61oXYSudq8qGlg6ezpOMsS9tswK8Hb2MOFUCztyuKrbI9ICTLJkXA9i8fuyQJLvv+MIb3891g2c9qvC/BUG96hzS9qfVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDb7a5Nd; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b98a619f020so1517499a12.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 04:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764937831; x=1765542631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvQc9yTuqlOjoJmvorMP2zm/sODzUXr4OMWqekW9i3c=;
        b=HDb7a5NdQPrq7SBcHgaY7Ut/amnvBvFJVI9UMEcrrbHhEUQrh/G23Lv0bfcy96hZGJ
         yU2hYbmwAUdZi+9HEOEkdN72ZX0lJ6jzayPfozh1kOaPL0Vtb+f63MRME4JD9s2cfCcl
         mC+eWendet8nH0fQkoeXQAYglSnpsGJW9UHb5CmDS8GgOHCeTYtGMoaUjg/jC7OJEcAs
         LYbmvt62fvKu0wck5+T6SG3GnYcabVMPF5nSBOxj7XT0pE8d0Ztj9wjtbn6O9lPqLumr
         yJoP/yhc3kHw1BB2PmSaOh8PjWwhHxNauygRNFQ5FekSDIsji4dZzWUXeab85HuZ6ieE
         4oGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764937831; x=1765542631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvQc9yTuqlOjoJmvorMP2zm/sODzUXr4OMWqekW9i3c=;
        b=HzTUzf41bF4IS6hh/T+s3yV1MV6XsRIeXHMFh+SUsxD3pf9Ns2gKo1CXaHPxdbgt4m
         J5Q4r670/9j6m7kI8zgD6YDGQeiUPiLiZu+yjBwCktkaakuRthlKrdW/i8ljtOejUKDS
         klwEdbXk4B8mzHykiHIdKjT8jBqdLYF+N2jmooj+nXA50ytVpqDlIKgM0YccKsNq8N8V
         d/y3l9Pp3XRqVwYsWcq/b5q+TvuCVdOCCE1zvmRrp3RtK75M1ONtBixU7BaEihdAfHkP
         5yBnoQgDcDx6x0vyGhZ2Sl/PCylK0hOVcf4Bc4DGXpb9e2+BY9SIk7gvDVgbs199brRz
         x45Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLCBbF0YtIZhHuHKKWXWjICmnGedZf8IZOX/vJeMpnHFvx4wHVXnvbOo+DK+m2+gn2K/ID2oDWPIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8+qQzevELcZwiL1/hVzX+3iG+5UiR5tCQkwp4ZYwyh1Rm7Zw
	cA8nIbgrHA/GHzNcKtgLzKzybFZM4Go/Aitkmpby3/WwfbsLJ9uLw2yy
X-Gm-Gg: ASbGncsuMFr1D3VgqNxI0wK3pGln81UZ/7Ps5fF4mbm2FSlpsBP+8+s/gce3xGXX2r4
	XBKzSQ/sVerpnb0QBQaQ8q+2md9sFv6Z7A+LWf5rlbB34rHiMcMLtp5FC/ePiWNeOZWnjt9Y+Ut
	arpOKTk0zjs3ACz4nS4DtRUJ9Sq5HUuoilKXsL/1d+bxodALiA3kDOG2qO+hdyqReDnsGq65X/p
	0qy8vmIs853iFy4KJ5wkiNKr6whYp1EWqXGmOgRT0+c8Ys0bUN9FYaZTb3n5UE1Ax+kzIEpouGA
	M4YynhkGKENULgVJjc7LxhWLyTzJhxgdsvIQ51LNDNOs2Dgfn8jv7GRTxZeOCRaMqto2m2OCrYs
	XSGdj7IFC0/WBynxaX+NECoPQObVrKkV1Ed/XtOjn/0N/tlwkg606c2M3qnIl0596cOf4PFBqga
	FntOrA0cth9VV2kJVP9lyK
X-Google-Smtp-Source: AGHT+IG1w6AqAdjpiEW7wjkCwb9maP3V0YHpY8O2ibmOVgIoRsAmTpquVm5wmuPOFlElSwJ0pIUg/g==
X-Received: by 2002:a05:693c:2c09:b0:2a4:3594:72d5 with SMTP id 5a478bee46e88-2ab92d545d2mr7178256eec.4.1764937830922;
        Fri, 05 Dec 2025 04:30:30 -0800 (PST)
Received: from localhost ([2804:30c:2712:fd00:9579:9ff6:e506:6147])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2aba8395d99sm20637786eec.1.2025.12.05.04.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 04:30:30 -0800 (PST)
Date: Fri, 5 Dec 2025 09:32:04 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v3 3/3] Docs: iio: Add AD4134
Message-ID: <aTLQxIGc5jMgQnnx@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1764708608.git.marcelo.schmitt@analog.com>
 <69b230190abb4cd76ad9eb25e2bde51caaa23d9a.1764708608.git.marcelo.schmitt@analog.com>
 <19d5c51d-41f3-446a-aced-5be2fe6ec0d2@vaisala.com>
 <aTGpgEFew2vP1CTG@debian-BULLSEYE-live-builder-AMD64>
 <49465e36-882c-41c2-a8bb-3c2e87bcdfd7@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49465e36-882c-41c2-a8bb-3c2e87bcdfd7@vaisala.com>

On 12/05, Tomas Melin wrote:
> Hi,
> 
> On 04/12/2025 17:32, Marcelo Schmitt wrote:
> > On 12/03, Tomas Melin wrote:
> >> Hi,
> >>
> >> On 02/12/2025 22:55, Marcelo Schmitt wrote:
> >>> Add initial documentation for the ad4134 IIO driver.
> >>
> >> I wonder is there some information in here that is not readily available
> >> in the device datasheet? After all, isn't idea with this file to
> >> document peculiarities that are not easily found elsewhere?
> > 
> > You are correct, these docs are mostly from data sheet info.
> > The main idea of having the doc is to make clear what peripheral connection
> > schema is currently supported.
> > Because AD4134 is both flexible and somewhat extensible in the way it can be
> > connected to the host, we could have different wiring configurations, for
> > example
> 
> Thanks for your explanation. My humble opinion is that it would be
> enough to mention in the commit message for the driver being added, or
> in the device-tree bindings that basic I/O mode is only configuration
> that is currently supported.

Okay, I'll drop the docs from v4.

Thanks,
Marcelo

