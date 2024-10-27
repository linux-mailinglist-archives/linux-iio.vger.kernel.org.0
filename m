Return-Path: <linux-iio+bounces-11392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE56F9B1D41
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 11:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B011F21789
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F7E126BFF;
	Sun, 27 Oct 2024 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruIqJWrr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26CA14E2D8
	for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2024 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730025270; cv=none; b=qbH96ppqdFi3hW4sBpCXle4Z7huZL6pAtCwo+y/QtsFT80gceoUI9MD1a4npnY4kOiBag0O/THAEif6b+YIX33YuI8W3lhGg4x3CIcjxiXpOhhyTIWdw5Cn27yLTpa07pPeKe9MblryiCvEpOAuvbDF4IFzPrcvld1UVJ9lNf9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730025270; c=relaxed/simple;
	bh=tkz/XmCw7cw7BxlpqWDFsSdoF3gZTsS1LFn+MEOdh9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BeAi6ke1Fdmzn9rSCLhRx5JDbpBCSeGZEkuMvWFYdz0CdqJauJu7VbVbjBWKmlXcA8oGDZaik38Tlb3OvfbqaFDf+zrsCbahjJfcujcNwfUmTZDgIyrds9J0aK08hF/EdOsaPMZ22HFHKhwmqwpE5O/ujNoCFAfi6fFe2kNBaDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruIqJWrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63A4C4CEC3;
	Sun, 27 Oct 2024 10:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730025269;
	bh=tkz/XmCw7cw7BxlpqWDFsSdoF3gZTsS1LFn+MEOdh9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ruIqJWrrWpdVMx/crzZdc2ZJO8NP+z6RLHoK9FSXX7Qo+6KMoCteW88sLep/VInJM
	 8oKWan73bJs8GBWR5WyIQUFi4byOcDFqCCbg7elxeGU7U5wSYpbpsJLnaRDHaWRReH
	 RxuVrqEhKOj1HFMDUIrWTqZSbfKN8dePJsn/NDn/fpPO/Gw8r3ARf47rNts/0hdP/W
	 q4WlBwtvcWiFjowmSbAaaKN5hvEJqFeYhIMS88oK2rbHqolMtFL4pac2xCJyTDMQUO
	 VcxhxIilMHL5fF/D5ihfrJhfgtT9cNegC2H3R7jb7jy9WtRni7UYm72wdymNf+5D5X
	 HB05jfU/DavgQ==
Date: Sun, 27 Oct 2024 10:34:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: Re: [Bug 219418] BOSC0200 Accelerometer Invalid chip 12
 initialization error
Message-ID: <20241027103423.3861dc67@jic23-huawei>
In-Reply-To: <bug-219418-217253-VYnzz91hlr@https.bugzilla.kernel.org/>
References: <bug-219418-217253@https.bugzilla.kernel.org/>
	<bug-219418-217253-VYnzz91hlr@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Oct 2024 17:06:36 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=219418
> 
> --- Comment #4 from Camera Phone (cameraphone77@gmail.com) ---
> (In reply to Jonathan Cameron from comment #3)
> > On Tue, 22 Oct 2024 13:17:20 +0000
> > bugzilla-daemon@kernel.org wrote:
> >   
> > > https://bugzilla.kernel.org/show_bug.cgi?id=219418
> > > 
> > >             Bug ID: 219418
> > >            Summary: BOSC0200 Accelerometer Invalid chip 12 initialization
> > >                     error
> > >            Product: Drivers
> > >            Version: 2.5
> > >           Hardware: All
> > >                 OS: Linux
> > >             Status: NEW
> > >           Severity: normal
> > >           Priority: P3
> > >          Component: IIO
> > >           Assignee: drivers_iio@kernel-bugs.kernel.org
> > >           Reporter: cameraphone77@gmail.com
> > >         Regression: No
> > > 
> > > Created attachment 307035 [details]  
> > >   --> https://bugzilla.kernel.org/attachment.cgi?id=307035&action=edit    
> > > lspci output
> > > 
> > > Hardware: Acer aspire spin 3 A3SP14-31PT-38YA
> > > 
> > > One line summary of the problem:
> > > BOSC0200 Accelerometer Invalid chip 12 initialization error  
> > 
> > Unfortunately that ID is used by the windows Bosch drivers for numerous
> > completely incompatible devices.  So we can't do soft matching on this one.
> > We need to know what the device actually is and add explicit support for
> > it.
> > 
> > So it's going to take some detective work to find a device with ID 12.
> > 
> > Any other information on what device this might be?
> > 
> > Jonathan  
> 
> I looked through all the bosch accelerator datasheets I could find and the
> closest i could get was:
> 
> CHIP     chip_id
> BMA423 - 0x13
> BMA456 - 0x16
> 
> I'm thinking it may be the BMA422 but that datasheet isn't available for some
> reason.   I did also ask in their forums but no responses.  Unfortunately, I
> don't think it's an easy task to disassemble the screen.
> 
Without a datasheet this is hard, but you 'could' try just hacking in the
ID in the driver and see what works?  Particularly if scales match up with the
stuff on the flyer that is available for the BMA422.

Jonathan



