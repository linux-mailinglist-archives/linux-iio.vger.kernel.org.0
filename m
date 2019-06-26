Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1A656837
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 14:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfFZMHN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 08:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZMHN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 08:07:13 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4EAD20656;
        Wed, 26 Jun 2019 12:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561550832;
        bh=jXGutaTjejtrAQAneu9IrbdI/efrD3y52cxsTEwVDGY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Ad1D0480qprxHCrqmW/MmgrEoYC0r8Fietb9QqJ476F3/oGBFdWBuCtThCCWv46mf
         ugAzLfn773BdCrbVgTfERcWmSU/Ah8Upw0PFL/EEUKYMu3kgKQRGLcZJ6e47EeuWg8
         JH3qavwhxXvLxOLFksZdedReoTCyJ5jfNsCXJ1ew=
Date:   Wed, 26 Jun 2019 14:07:08 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     hongyan.song@intel.com
cc:     srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, hdegoede@redhat.com, jic23@kernel.org,
        even.xu@intel.com
Subject: Re: [PATCH v3] hid: remove NO_D3 flag when remove driver
In-Reply-To: <1559434641-11783-1-git-send-email-hongyan.song@intel.com>
Message-ID: <nycvar.YFH.7.76.1906261406120.27227@cbobk.fhfr.pm>
References: <1559434641-11783-1-git-send-email-hongyan.song@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2 Jun 2019, hongyan.song@intel.com wrote:

> From: Song Hongyan <hongyan.song@intel.com>
> 
> Remove the NO_D3 flag when remove the driver and let device enter
> into D3, it will save more power.
> 
> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v3 changes: 
> After test the former implmentation, we found FW will enter D3 when
> system enter into S0i3. Change the implementation to meet the requirement:
> device enter D3 and have no impact to ISH platform.

Srinivas, I'd prefer changes like this to go to Linus tree in merge window 
and not -rc phase, so I'll do that unless you tell me there is a good 
reason to push it to Linus still in -rc.

Thanks,

-- 
Jiri Kosina
SUSE Labs

