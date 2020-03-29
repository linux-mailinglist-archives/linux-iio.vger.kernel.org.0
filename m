Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9684F196FAD
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 21:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgC2TXB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 15:23:01 -0400
Received: from mail.computer-surgery.co.uk ([82.69.253.61]:60075 "EHLO
        nicole.computer-surgery.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727370AbgC2TXB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2020 15:23:01 -0400
X-Greylist: delayed 2565 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Mar 2020 15:23:00 EDT
Received: from [10.94.89.11] (helo=kilburn)
        by nicole.computer-surgery.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <roger@gammascience.co.uk>)
        id 1jIcqy-0006gg-30; Sun, 29 Mar 2020 19:40:12 +0100
Received: from roger by kilburn with local (Exim 4.92)
        (envelope-from <roger@kilburn.gammascience.co.uk>)
        id 1jIcqs-00033T-8L; Sun, 29 Mar 2020 18:40:06 +0000
Date:   Sun, 29 Mar 2020 18:40:06 +0000
From:   Roger Gammans <rgammans@gammascience.co.uk>
To:     Sandeep Singh <Sandeep.Singh@amd.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v4 4/4] SFH: Create HID report to Enable support of AMD
 sensor fusion Hub (SFH)
Message-ID: <20200329184006.GA8199@kilburn.gammascience.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 27, 2020 at 05:10:57AM +0000, Sandeep Singh wrote:

> From: Sandeep Singh <sandeep.singh@amd.com>
> 
> +#include "amd_sfh_hid_report_descriptor.h"
> +#include "amd_mp2_pcie.h"

I had to change the last line to 

  #include "../amd_mp2_pcie.h"

to make it compile out of tree. After that I got a clean compile.

Also I don't seem to be getting any data through
to monitor-sensor in user space when I do install it, but I am
gettting logs of log messages similar to this:

 pcie_mp2_amd 0000:04:00.7: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0x5267f000 flags=0x0020]
 pcie_mp2_amd 0000:04:00.7: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0x5267f000 flags=0x0020]

This is compiled against the debian 5.4.0 kernel, on a
     HP ENVY x360 Convertible 15-ds0xxx, SKU 6TD07EA#ABU

I can run other tests or try other kernels if you think it might help,
let me know what you need.

-- 
Roger Gammans
