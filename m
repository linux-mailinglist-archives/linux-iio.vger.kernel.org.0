Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89AF856DA7
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 17:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfFZPaC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 11:30:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:26752 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfFZPaC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 11:30:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 08:30:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="245459984"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga001.jf.intel.com with ESMTP; 26 Jun 2019 08:30:01 -0700
Message-ID: <67a1ec6dd44866c29333f5b05184cc402bc20382.camel@linux.intel.com>
Subject: Re: [PATCH v3] hid: remove NO_D3 flag when remove driver
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>, hongyan.song@intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        hdegoede@redhat.com, jic23@kernel.org, even.xu@intel.com
Date:   Wed, 26 Jun 2019 08:30:01 -0700
In-Reply-To: <nycvar.YFH.7.76.1906261406120.27227@cbobk.fhfr.pm>
References: <1559434641-11783-1-git-send-email-hongyan.song@intel.com>
         <nycvar.YFH.7.76.1906261406120.27227@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2019-06-26 at 14:07 +0200, Jiri Kosina wrote:
> On Sun, 2 Jun 2019, hongyan.song@intel.com wrote:
> 
> > From: Song Hongyan <hongyan.song@intel.com>
> > 
> > Remove the NO_D3 flag when remove the driver and let device enter
> > into D3, it will save more power.
> > 
> > Signed-off-by: Song Hongyan <hongyan.song@intel.com>
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> > v3 changes: 
> > After test the former implmentation, we found FW will enter D3 when
> > system enter into S0i3. Change the implementation to meet the
> > requirement:
> > device enter D3 and have no impact to ISH platform.
> 
> Srinivas, I'd prefer changes like this to go to Linus tree in merge
> window 
> and not -rc phase, so I'll do that unless you tell me there is a
> good 
> reason to push it to Linus still in -rc.
Correct. I will tell you if it is important enough to go to -rc
release, otherwise all changes you can assume for the next merge
window.

This change is also for the next merge window.

Thanks,
Srinivas

> 
> Thanks,
> 

