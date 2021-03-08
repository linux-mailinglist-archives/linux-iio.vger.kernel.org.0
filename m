Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DDA3312B9
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 17:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhCHQA4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 11:00:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:20160 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230148AbhCHQAs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Mar 2021 11:00:48 -0500
IronPort-SDR: qGAn2jkSazw168RkMm0T9BZb9nvVxoDZtLKzoTAi1+duqCYyWBhOn5cjAHh0R6fIO6lWC8BaiL
 mp9sR3r+s6oQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="252081110"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="252081110"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:00:43 -0800
IronPort-SDR: B1b74B1yMTqj5Dr9tfyahDvUZ/aOJ8ccU+6DLUh9DF44qFfPJ32yU3L4nggjd+ZOlDxLl1z4vw
 OQeEo+8PkVsA==
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="408271207"
Received: from arohrbax-mobl.amr.corp.intel.com ([10.209.91.130])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:00:43 -0800
Message-ID: <00ad0906b90a290e9737b7bf7d8c5ab9c6ed61e6.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel_ish-hid: HBM: Use connected standby state
 bit during suspend/resume
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>, Ye Xiang <xiang.ye@intel.com>
Cc:     jic23@kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Mar 2021 08:00:41 -0800
In-Reply-To: <nycvar.YFH.7.76.2103081125380.12405@cbobk.fhfr.pm>
References: <20210303062825.7724-1-xiang.ye@intel.com>
         <nycvar.YFH.7.76.2103081125380.12405@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2021-03-08 at 11:26 +0100, Jiri Kosina wrote:
> On Wed, 3 Mar 2021, Ye Xiang wrote:
> 
> > ISH firmware uses connected standby state bit
> > (CONNECTED_STANDBY_STATE_BIT bit 1)
> > to notify current power state to sensors instead of suspend state
> > bit (bit 0).
> > So send both SUSPEND_STATE_BIT and CONNECTED_STANDBY_STATE_BIT to
> > firmware
> > to be compatible with the previous version.
> 
> Could you please make the changelog more verbose -- namely what 
> user-visible issue this is fixing?
Xiang,

I think this change is for related to Elkhart Lake for support of
connected standby (keep listening for sensor events during Linux
suspend for some sensors). In this way some sensor can wake up the
system.

Thanks,
Srinivas





> 
> Thanks.
> 

