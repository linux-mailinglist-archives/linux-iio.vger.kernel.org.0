Return-Path: <linux-iio+bounces-3262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D16386F1FC
	for <lists+linux-iio@lfdr.de>; Sat,  2 Mar 2024 20:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C9FB22130
	for <lists+linux-iio@lfdr.de>; Sat,  2 Mar 2024 19:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B0A3FB2C;
	Sat,  2 Mar 2024 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rjcp/obN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9EB26AD8
	for <linux-iio@vger.kernel.org>; Sat,  2 Mar 2024 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709406225; cv=none; b=N9JPQXSTpbITpqMRAQhn0Uw/ezrFCKyn694vnD332cax60H05pwfQHJlg2bymRYmQFcoaY7q+h+/tlIyZe448yvhCQnTME9SRaZTjYkqYzLMAMQOfQ5KEujXndT3ORGML5a2gWmSuPXfw8ork90CwDO11cNtdI6kVlYins89CKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709406225; c=relaxed/simple;
	bh=prysH5TbuFpsyOkyGPM7p4CdHbQUQ+Jf456FfNwHx7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psFxRaSKUm3Gls9+yZeMPwaAtV+Rmqnevu5/D/1sqZ9jlNGeKKWejphnc/CukrOQPLIGFGleNuyX1ZLAUtLhJE0MDek6a+CKEg218BYZnRFxxmZTttTYwZYOIXGZL5JE1a289RP9Eh7zk7pTQR94BoIXlAXGUPrnXAVWcsv8ROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rjcp/obN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5082C433C7;
	Sat,  2 Mar 2024 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709406225;
	bh=prysH5TbuFpsyOkyGPM7p4CdHbQUQ+Jf456FfNwHx7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rjcp/obN1JYyGot+TnRoQjFeNghSqS1ZGdFmqnuIMH0pTXFKzo3eg7s6heqDQFVjg
	 NeLhwP72ULV4jQqXfvHsi8WE0KN0iQ8Hpg9cu+A4fy9rOwEJMEFwjVLgONzmfKfWSn
	 PLZHp0qrqeAlJU76gaWYIvdtZisTkFocuORIEdwY=
Date: Sat, 2 Mar 2024 20:03:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of new device support features etc for 6.9.
Message-ID: <2024030224-geometry-barrier-71b5@gregkh>
References: <20240229201056.45abd048@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229201056.45abd048@jic23-huawei>

On Thu, Feb 29, 2024 at 08:10:56PM +0000, Jonathan Cameron wrote:
> The following changes since commit d4551c189d6e6a3fcf7f625bd4b273e770fad35a:
> 
>   Merge tag 'iio-for-6.9a' of http://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next (2024-02-25 14:11:41 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.9b

Pulled and pushed out, thanks.

greg k-h

