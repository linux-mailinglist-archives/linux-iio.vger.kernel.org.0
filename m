Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292191B2026
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 09:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgDUHn5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 03:43:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:44548 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgDUHn5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Apr 2020 03:43:57 -0400
IronPort-SDR: GvcYGzyDAQG9eFibqszA4LNcJKaxpKNHu5+7M5rJad9LUV9JUV4yaUKn/q8KW4h0c9IxrPNUBL
 paze5cB9MrYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 00:43:56 -0700
IronPort-SDR: AU4U89muze9SpjkdQQxFBWt4xPs98GKFbShrX7yEZnQAOwxeuz7y3EVjYsSURbo7SZv/OqWBTB
 KEH4JFx7uZ3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,409,1580803200"; 
   d="scan'208";a="365267838"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 21 Apr 2020 00:43:53 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 Apr 2020 10:43:53 +0300
Date:   Tue, 21 Apr 2020 10:43:53 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>, linux-usb@vger.kernel.org
Subject: Re: ucsi and DRD controller interaction
Message-ID: <20200421074353.GE3768833@kuha.fi.intel.com>
References: <26823688-3b9c-5869-bcb6-4d6e5dcd77bc@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26823688-3b9c-5869-bcb6-4d6e5dcd77bc@amd.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adding linux-usb mailing list.

On Mon, Apr 20, 2020 at 07:09:17PM +0530, Shah, Nehal-bakulchandra wrote:
> Hi Heikki ,
> 
> I need some pointer from you, so in a system where I have UCSI driver for DRD
> Controller, then how call stack will be?
> 
> I am unable to comprehend the flow from UCSI infrastructure to DRD controller
> code base.

Do you need to tell the negotiated data role to your USB controller
driver from the UCSI driver? For that we would need to know which USB
controller, or more precisely, which USB port is connected to the
USB Type-C connector in question.

That would require ACPI tables to be able to describe the connection
between the USB Type-C connector and the USB port (and the connection
between DisplayPort and the USB Type-C connector etc.). Unfortunately
there is currently no documented way of doing that, however, there is
a proposal for a document the defines how the USB Type-C connectors
should be described in ACPI in general. The proposal does consider
this problem as well. For this the solution is to use _DSD device
properties "usb2-port" and "usb3-port" that have references to the
correct USB port nodes as values.

Which USB controller are you using btw?

thanks,

-- 
heikki
