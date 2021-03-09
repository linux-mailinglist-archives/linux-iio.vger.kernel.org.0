Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF64E33237E
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 12:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhCIK7u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 05:59:50 -0500
Received: from smtp2.macqel.be ([109.135.2.61]:7855 "EHLO smtp2.macqel.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229881AbhCIK7m (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 9 Mar 2021 05:59:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp2.macqel.be (Postfix) with ESMTP id 66914158AC3;
        Tue,  9 Mar 2021 11:59:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
        by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hW8seRXRk+YE; Tue,  9 Mar 2021 11:59:38 +0100 (CET)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
        by smtp2.macqel.be (Postfix) with ESMTP id A42A8130CB5;
        Tue,  9 Mar 2021 11:59:38 +0100 (CET)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id 87178BEC0C8; Tue,  9 Mar 2021 11:59:38 +0100 (CET)
Date:   Tue, 9 Mar 2021 11:59:38 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: invensense mpu9250 ak8963 and devicetree
Message-ID: <20210309105938.GA16399@frolo.macqel>
References: <20210303153145.GA30260@frolo.macqel> <BL0PR12MB501190F3812AA541BDBEF625C4979@BL0PR12MB5011.namprd12.prod.outlook.com> <20210308130630.GA3363@frolo.macqel> <20210308172427.000032d2@Huawei.com> <20210309101126.GA11691@frolo.macqel> <c5860a82-e3ba-3409-a711-847c8bcf7e1e@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5860a82-e3ba-3409-a711-847c8bcf7e1e@metafoo.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thank you Lars,

On Tue, Mar 09, 2021 at 11:46:54AM +0100, Lars-Peter Clausen wrote:
> On 3/9/21 11:11 AM, Philippe De Muyter wrote:
>> I use a kernel provided by nvidia that is called tegra-l4t-r32.3.1, but
>> is based on v4.9.
>> Although the patch that provides automatically stub regulators
>>   4ddfebd3b "regulator: core: Provide a dummy regulator with full 
>> constraints"
>> is older than v3.13, I have found in the commits of my kernel on top of
>> v4.9, this one
> [...]
>> And CONFIG_REGULATOR_DUMMY is disabled in the default kernel configuration
>> provided by nvidia :(
>
> To work around this you can add a fixed-regulator to your devicetree and 
> connect it to the IMU. 
> Seehttps://www.kernel.org/doc/Documentation/devicetree/bindings/regulator/fixed-regulator.txt

I have enabled REGULATOR_DUMMY and that solved the problem.

Philippe
