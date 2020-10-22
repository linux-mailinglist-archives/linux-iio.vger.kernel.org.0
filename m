Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CF0295C63
	for <lists+linux-iio@lfdr.de>; Thu, 22 Oct 2020 12:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896260AbgJVKFr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Oct 2020 06:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896255AbgJVKFr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 22 Oct 2020 06:05:47 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B240F223BF;
        Thu, 22 Oct 2020 10:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603361146;
        bh=RdXIhAzgvdf9lHDSgJdqMCuGQDCw4QI27Nnn5KK2Imc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=0XQMNgUwwyxLxH1zOkfveBbzM4nT9psGhxJ4v6GJes0/S8AKLHtj1RG2Y0wGMVbz/
         o35PmcaIlFln9qZyLP8opXKrJFQFn0SOEWwMHzlZocxpQNC3h3ze8GKEsNEuAnbCBK
         gYSfqKiAOjMZwVfNYyjeu0F/sSTG3JxfyGgCHH+U=
Date:   Thu, 22 Oct 2020 12:05:41 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sandeep Singh <Sandeep.Singh@amd.com>
cc:     benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de,
        rdunlap@infradead.org, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH v8 0/4] SFH: Add Support for AMD Sensor Fusion Hub
In-Reply-To: <20201009200138.1847317-1-Sandeep.Singh@amd.com>
Message-ID: <nycvar.YFH.7.76.2010221205110.18859@cbobk.fhfr.pm>
References: <20201009200138.1847317-1-Sandeep.Singh@amd.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 10 Oct 2020, Sandeep Singh wrote:

> From: Sandeep Singh <sandeep.singh@amd.com>
> 
> AMD SFH(Sensor Fusion Hub) is HID based driver.SFH FW is part of MP2
> processor (MP2 which is an ARM core connected to x86 for processing 
> sensor data) and it runs on MP2 where in the driver resides on X86.
> The driver functionalities are divided into three parts:-
> 
> 1: amd-mp2-pcie:- This part of the module will communicate with MP2
> 		  firmware. MP2 which is exposed as a PCI device to the 
> 		  X86, uses mailboxes to talk to MP2 firmware to 
> 		  send/receive commands.
> 2: Client Layer:- This part of the driver will use DRAM  data and convert
>                   the  data into HID format based on HID reports.
> 3: Transport layer :- This part of the driver the will communicate with HID
>                   core.Communication between devices and HID core is
>                   mostly done via HID reports
> 
> In terms of architecture, it resembles like ISH (Intel Integrated Sensor
> Hub). However the major difference is all the hid reports are generated
> as part of the kernel driver.
> 
> AMD SFH is integrated as a part of SoC, starting from 17h family of
> processors. The solution is working well on several OEM products.
> AMD SFH uses HID over PCIe bus.
> 
> Changes since v1:
>         -> Fix auto build test warnings
>         -> Fix smatch warnings "possible memory leak" -Reported by Dan
> carpenter
> 
> Links of the review comments for v1:
>         [1] https://patchwork.kernel.org/patch/11325163/
>         [2] https://patchwork.kernel.org/patch/11325167/
>         [3] https://patchwork.kernel.org/patch/11325171/
>         [4] https://patchwork.kernel.org/patch/11325187/
> 
> Changes since v2:
> 	-> Debugfs divided into another patch
>         -> Fix some cosmetic changes
>         -> Fix for review comments
>            Reported and Suggested by:-  Srinivas Pandruvada
> 
> Links of the review comments for v2:
>         [1] https://patchwork.kernel.org/patch/11355491/
>         [2] https://patchwork.kernel.org/patch/11355495/
>         [3] https://patchwork.kernel.org/patch/11355499/
>         [4] https://patchwork.kernel.org/patch/11355503/
> 
> Changes since v3:
>         -> Removed debugfs suggested by - Benjamin Tissoires
> 
> Links of the review comments for v3:
>         [1] https://lkml.org/lkml/2020/2/11/1256
>         [2] https://lkml.org/lkml/2020/2/11/1257
>         [3] https://lkml.org/lkml/2020/2/11/1258
>         [4] https://lkml.org/lkml/2020/2/11/1259
>         [5] https://lkml.org/lkml/2020/2/11/1260
> 
> Changes since v4:
>         -> use PCI managed calls.
>         -> use kernel APIs
> 
> Links of the review comments for v4:
>         [1] https://lkml.org/lkml/2020/2/26/1360
>         [2] https://lkml.org/lkml/2020/2/26/1361
>         [3] https://lkml.org/lkml/2020/2/26/1362
>         [4] https://lkml.org/lkml/2020/2/26/1363
>         [5] https://lkml.org/lkml/2020/2/27/1
> Changes since v5
>         -> Fix for review comments by: Andy Shevchenko
>         -> Fix for indentations erros, NULL pointer,Redundant assignment
>         -> Drop LOCs in many location
>         -> Create as a single driver module instead of two modules.
> 
> Links of the review comments for v5:
>         [1] https://lkml.org/lkml/2020/5/29/589
>         [2] https://lkml.org/lkml/2020/5/29/590
>         [3] https://lkml.org/lkml/2020/5/29/606
>         [4] https://lkml.org/lkml/2020/5/29/632
>         [5] https://lkml.org/lkml/2020/5/29/633
> 
> Changes since v6
>         -> fix Kbuild warning "warning: ignoring return value of
> 	   'pcim_enable_device',
>         -> Removed select HID and add depends on HID
> 
> Links of the review comments for v6:
>         [1] https://lkml.org/lkml/2020/8/9/58
>         [2] https://lkml.org/lkml/2020/8/9/59
>         [3] https://lkml.org/lkml/2020/8/9/125
>         [4] https://lkml.org/lkml/2020/8/9/61
>         [5] https://lkml.org/lkml/2020/8/9/91
> 
> Changes since v7
>         -> Add Co-deveploed-by
>         -> Build the Documentation
>         -> Fix cosmatic changes
>         -> Add init function inside probe function
>         -> Use devm_add_action_or_reset() to avoids the remove()
> 	   callback.
> 
> Links of the review comments for v7:
>         [1] https://lkml.org/lkml/2020/8/10/1221
>         [2] https://lkml.org/lkml/2020/8/10/1222
>         [3] https://lkml.org/lkml/2020/8/10/1223
>         [4] https://lkml.org/lkml/2020/8/10/1224
>         [5] https://lkml.org/lkml/2020/8/10/1225
> 
> Sandeep Singh (4):
>   SFH: Add maintainers and documentation for AMD SFH based on HID
>     framework
>   SFH: PCIe driver to add support of AMD sensor fusion hub
>   SFH:Transport Driver to add support of AMD Sensor Fusion Hub (SFH)
>   SFH: Create HID report to Enable support of AMD sensor fusion Hub
>     (SFH)

I have now applied the series to hid.git#for-5.11/amd-sfh-hid. Thanks for 
all the efforts in tidying this up,

-- 
Jiri Kosina
SUSE Labs

