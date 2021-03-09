Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAE7331DAF
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 04:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhCIDpi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 22:45:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:29506 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhCIDph (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Mar 2021 22:45:37 -0500
IronPort-SDR: WPAgq3cVmbs9CC5IfdUpTZgwg5W9i+rSOtuQhPj+7bMLMOfihRVTls3hCm4ZM00ZlucDj1u97P
 cTYhLUj8RYnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="185766829"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="185766829"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 19:45:37 -0800
IronPort-SDR: xAF1BZV6aIdcX20k5nC8IpvHiYys6X3Et9tEMjHpto2M/YBoqJSX2oqhqtzsJQOZ5ZTeo9T2mL
 SBhf6BtnJMXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="430608462"
Received: from host.sh.intel.com (HELO host) ([10.239.154.115])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2021 19:45:36 -0800
Date:   Tue, 9 Mar 2021 11:47:42 +0800
From:   "Ye, Xiang" <xiang.ye@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     jic23@kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel_ish-hid: HBM: Use connected standby state bit
 during suspend/resume
Message-ID: <20210309034742.GA18299@host>
References: <20210303062825.7724-1-xiang.ye@intel.com>
 <nycvar.YFH.7.76.2103081125380.12405@cbobk.fhfr.pm>
 <00ad0906b90a290e9737b7bf7d8c5ab9c6ed61e6.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ad0906b90a290e9737b7bf7d8c5ab9c6ed61e6.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Srinivas, Jiri

On Mon, Mar 08, 2021 at 08:00:41AM -0800, Srinivas Pandruvada wrote:
> On Mon, 2021-03-08 at 11:26 +0100, Jiri Kosina wrote:
> > On Wed, 3 Mar 2021, Ye Xiang wrote:
> > 
> > > ISH firmware uses connected standby state bit
> > > (CONNECTED_STANDBY_STATE_BIT bit 1)
> > > to notify current power state to sensors instead of suspend state
> > > bit (bit 0).
> > > So send both SUSPEND_STATE_BIT and CONNECTED_STANDBY_STATE_BIT to
> > > firmware
> > > to be compatible with the previous version.
> > 
> > Could you please make the changelog more verbose -- namely what 
> > user-visible issue this is fixing?
> Xiang,
> 
> I think this change is for related to Elkhart Lake for support of
> connected standby (keep listening for sensor events during Linux
> suspend for some sensors). In this way some sensor can wake up the
> system.
This change is for all ISH platform. Currently, ISH firmware use
both SUSPEND_STATE_BIT and CONNECTED_STANDBY_STATE_BIT to identify
system state. It is related to system wake up by ISH and it enable each
sensor in ISH to be notified the current system state, when system state
change.

Thanks
Ye Xiang
> 
> 
> 
> 
> 
> 
> 
