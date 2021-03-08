Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC82330B0E
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 11:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhCHK0k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 05:26:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhCHK0I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Mar 2021 05:26:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C84FE65101;
        Mon,  8 Mar 2021 10:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615199168;
        bh=pVTgs4Pr6FSkT+T6A68uw3AFO3E3XyqGrFq4/W3q7Jg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=hFDa2NSIA4xynalVVl+7CSHSbb8o4J84/UMycbU7vDKY6hfAfFNVOnSbK46ptpAe8
         ZmlrujQryjveeWqKLJCo4qoRDmL3BkUmq4CTJZsMc/dHb19AhiXOCr7+u47J9bdIsr
         k/8h/F8jswKearqFx3Ii2l6T99m/LpAJ/4wfe+gRJluY1WvOXkiIY5ib7OetYq9BKL
         eMl8fJoFWjJc6ctRB0hLj6Df+Z9ZtsdEMSxThigUnalC8e/SntoFH/8+RCDpHhAZoA
         oZIhwa6HqxoBF8smFXMHksDrcNoVHJowS8D0cAQYh4La2CWDks6Lwoko/Y/pM11Z8V
         XfzQrsWENETCA==
Date:   Mon, 8 Mar 2021 11:26:04 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
cc:     jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel_ish-hid: HBM: Use connected standby state
 bit during suspend/resume
In-Reply-To: <20210303062825.7724-1-xiang.ye@intel.com>
Message-ID: <nycvar.YFH.7.76.2103081125380.12405@cbobk.fhfr.pm>
References: <20210303062825.7724-1-xiang.ye@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 3 Mar 2021, Ye Xiang wrote:

> ISH firmware uses connected standby state bit (CONNECTED_STANDBY_STATE_BIT bit 1)
> to notify current power state to sensors instead of suspend state bit (bit 0).
> So send both SUSPEND_STATE_BIT and CONNECTED_STANDBY_STATE_BIT to firmware
> to be compatible with the previous version.

Could you please make the changelog more verbose -- namely what 
user-visible issue this is fixing?

Thanks.

-- 
Jiri Kosina
SUSE Labs

