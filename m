Return-Path: <linux-iio+bounces-16809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D8CA60A69
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 08:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC1417FE95
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 07:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93C2194A65;
	Fri, 14 Mar 2025 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EQ7oz+iH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81918A924
	for <linux-iio@vger.kernel.org>; Fri, 14 Mar 2025 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938684; cv=none; b=hyXGuyGIphwKULU4as3PXMwEDpuurc0ZTStEcBdbDIeYfulU+0NWVCoI0BOW599SPvraWtJ0joXVEl1fN2Tks8Lp1R46+Jp+PZR73ozwZGnG8fcqtfW+s22OdYC0SYDNtsY1i3T//QqKAlwdfPy3/ZkYWCnNCiSlGsTAWQYseiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938684; c=relaxed/simple;
	bh=dcFZKPWbVi2HTz5hB0XlzGI97NIek3okzhs6e43XX/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFqliUwe7jhxy6rkD2nsq4Vh4awGUVLIisX97LrFof3/euGwWwvdK7mAIuUGD+hGopPQ7TGnIf7eDycBzjjg2TD6iqXlTk0sQUr0Tif8eAhUAV89TvNtm6z0HA9psBHhZf+tChmCsjNFZQ4HVLC/zFPYioFtlTl6n44Q0AcSJA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EQ7oz+iH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CEBC4CEE3;
	Fri, 14 Mar 2025 07:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741938684;
	bh=dcFZKPWbVi2HTz5hB0XlzGI97NIek3okzhs6e43XX/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQ7oz+iH1RqwloaOpHYwF+ZBYRtzCXNA/70dahoITzy7e7zNSYjSguZRMQnaCJACJ
	 ccCf/JGTnhTMiRpuNe+rdfUCmKIkCmQGBxLuPWl2guUW0DEM2VL/MAVwuajufpOy23
	 apZsZQn33iyYoxgfKnmmvDankhHa9Gw4hk81xBkI=
Date: Fri, 14 Mar 2025 08:51:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] Counter fixes for 6.14
Message-ID: <2025031406-parsley-stride-73b5@gregkh>
References: <Z8rD-jRvDNHPL-ha@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8rD-jRvDNHPL-ha@ishi>

On Fri, Mar 07, 2025 at 07:01:30PM +0900, William Breathitt Gray wrote:
> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> 
>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.14

Sorry for the delay, now pulled and pushed out.

greg k-h

