Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBB73322A7
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 11:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCIKLk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 05:11:40 -0500
Received: from smtp2.macqel.be ([109.135.2.61]:21584 "EHLO smtp2.macqel.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229689AbhCIKLb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 9 Mar 2021 05:11:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp2.macqel.be (Postfix) with ESMTP id C8F87130D0E;
        Tue,  9 Mar 2021 11:11:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
        by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a++AVs3viGFI; Tue,  9 Mar 2021 11:11:26 +0100 (CET)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
        by smtp2.macqel.be (Postfix) with ESMTP id CBDDB130CE5;
        Tue,  9 Mar 2021 11:11:26 +0100 (CET)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id ADFE8BEC0C8; Tue,  9 Mar 2021 11:11:26 +0100 (CET)
Date:   Tue, 9 Mar 2021 11:11:26 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: invensense mpu9250 ak8963 and devicetree
Message-ID: <20210309101126.GA11691@frolo.macqel>
References: <20210303153145.GA30260@frolo.macqel> <BL0PR12MB501190F3812AA541BDBEF625C4979@BL0PR12MB5011.namprd12.prod.outlook.com> <20210308130630.GA3363@frolo.macqel> <20210308172427.000032d2@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308172427.000032d2@Huawei.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

Thank you for your answer that led me to the explanation.

On Mon, Mar 08, 2021 at 05:24:27PM +0000, Jonathan Cameron wrote:
> 
> That's odd because you should get a stub regulator... For simple cases
> where the regulator is always on, there is no need to specify a regulator,
> you can just rely on the regulator framework giving you one that basically
> does nothing.
> 
> Could you have a look at why you aren't getting a dummy_regulator from the code
> just below here?
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/regulator/core.c#L1948
> 

I use a kernel provided by nvidia that is called tegra-l4t-r32.3.1, but
is based on v4.9.

Although the patch that provides automatically stub regulators
 4ddfebd3b "regulator: core: Provide a dummy regulator with full constraints"
is older than v3.13, I have found in the commits of my kernel on top of
v4.9, this one

commit 7f25dfa01aafe3d3ac1983a0d0f895775a80c005
Author: Laxman Dewangan <ldewangan@nvidia.com>
Date:   Tue Aug 11 18:28:53 2015 +0530

    regulator: core: do not allow dummy regulator if config not selected

    Do not allow dummy regulator if DUMMY REGULATOR not selected from
    config.

    Bug 200223300

    Change-Id: I672fb4f9d70f05bf3044b63c904be54e19c8ab36
    Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
    Reviewed-on: http://git-master/r/781784
    (cherry picked from commit 4e11e2b997d315587956e8537064277c5687bf70)
    Reviewed-on: http://git-master/r/1195179
    Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
    Reviewed-on: https://git-master.nvidia.com/r/1550248
    Tested-by: Ujwal Patel <ujwalp@nvidia.com>
    Reviewed-by: svc-mobile-coverity <svc-mobile-coverity@nvidia.com>
    Reviewed-by: svccoveritychecker <svccoveritychecker@nvidia.com>
    Reviewed-by: Shardar Mohammed <smohammed@nvidia.com>
    Tested-by: Shardar Mohammed <smohammed@nvidia.com>
    GVS: Gerrit_Virtual_Submit

And CONFIG_REGULATOR_DUMMY is disabled in the default kernel configuration
provided by nvidia :(

Philippe
