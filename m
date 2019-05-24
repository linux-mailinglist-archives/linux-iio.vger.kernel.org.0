Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E97F2943C
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2019 11:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389674AbfEXJKZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 May 2019 05:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389425AbfEXJKY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 24 May 2019 05:10:24 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4525205ED;
        Fri, 24 May 2019 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558689024;
        bh=lGN+Cywaq8H+sE5gF6NGv4eIntU+WT31VUYToX1nm4o=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=tNCFGjPOcr8wbx69MZNBYdQhCntwD4gTxyb60zcAEBjm4qR+7SX+zU3U7vMUgjV4N
         gQCbwEecE0xD17NiFDPC66gSj2gyzMLOuK3wAMMHhTtvwCZhzOquh1bNFy27pdwpWo
         lJNq+K+LPsjma1t2T0Hlg0xf0xys7mSYGoN5H8cU=
Date:   Fri, 24 May 2019 11:10:20 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
cc:     "Song, Hongyan" <hongyan.song@intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Xu, Even" <even.xu@intel.com>
Subject: Re: [PATCH] hid: remove NO_D3 flag for ish not CHV platform
In-Reply-To: <497b1b7fe4fca84f1a2bf450db196950c1e98310.camel@intel.com>
Message-ID: <nycvar.YFH.7.76.1905241109390.1962@cbobk.fhfr.pm>
References: <1558082782-29279-1-git-send-email-hongyan.song@intel.com>  <nycvar.YFH.7.76.1905221235140.1962@cbobk.fhfr.pm> <497b1b7fe4fca84f1a2bf450db196950c1e98310.camel@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 May 2019, Pandruvada, Srinivas wrote:

> > > From: Song Hongyan <hongyan.song@intel.com>
> Also commit summary "hid: remove NO_D3 flag for non Cherry Trail (CHT)"
> 
> > > 
> > > NO_D3 flag is set for CHV and the older platforms, the other
> > > platform
> > > suppose can enter D3, if have this NO_D3 flag set it can never
> > > enter D3
> > 
> > Could you please provide a little bit more descriptive changelog --
> > namely 
> > what observable problem is it fixing.
> 
> 
> In addition, I don't think this is a rc2+ release fix.

Thanks Srinivas. Could you please Ack v2 so that I could queue it?

-- 
Jiri Kosina
SUSE Labs

