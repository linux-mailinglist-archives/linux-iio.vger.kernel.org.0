Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019BE4E1C27
	for <lists+linux-iio@lfdr.de>; Sun, 20 Mar 2022 16:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245315AbiCTPG3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Mar 2022 11:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245312AbiCTPGY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2022 11:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEC513E3C;
        Sun, 20 Mar 2022 08:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCF9161138;
        Sun, 20 Mar 2022 15:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7BFC340E9;
        Sun, 20 Mar 2022 15:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647788700;
        bh=owHPsnbfCStY5+TEuj2uO+SHgNq78C6bh6WcvxZRbJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NifzXPJvq7pKpt0we2xlabCu0P9H7ASTqXR7t5C6AVE5tZ5hVl7ywp/RRuTd5DIf1
         el6JNhe4WN8F/1jDtIqY/0x51DXj3VwXdqiCtg7ofpgthYsz/b6ME7BJMCjBbOgHjo
         espspZXbe8+5S/pfHj4JQGUlHa6dX3O/Xis7vp36llYoUNeShgkJaf+8MTu+ZwIs7c
         /lTadSLkJa0zYu4uEDzmt0o+T16TYO6d9A7fuoHgd5Bx2geGmRrY4SBGiT8Mih+N/6
         jcMigBYtDzonr8jrmG1xQeW3bGx4rMMZAK00FAIvqQwJ6Q4u6KPS7DyjhOFmuesrYY
         V7sHcr3zHqatQ==
Date:   Sun, 20 Mar 2022 15:12:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Michael Srba <Michael.Srba@seznam.cz>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: Document
 invensense,icm20608d
Message-ID: <20220320151223.3a9b13bd@jic23-huawei>
In-Reply-To: <145bddd6-0a7e-95f4-5282-b1900f020d88@canonical.com>
References: <20220310133938.2495-1-michael.srba@seznam.cz>
        <20220310133938.2495-2-michael.srba@seznam.cz>
        <707f995e-9b09-ea23-5fc7-74239792dcbd@canonical.com>
        <2af7be38-7784-96af-aa3f-84b87d983b38@seznam.cz>
        <145bddd6-0a7e-95f4-5282-b1900f020d88@canonical.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Mar 2022 22:24:03 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:

> On 10/03/2022 19:56, Michael Srba wrote:
> > Hi,
> > the thing is, the only reason the different compatible is needed at all
> > is that the chip presents a different WHOAMI, and the invensense,icm20608
> > compatible seems to imply the non-D WHOAMI value.  
> 
> But this is a driver implementation issue, not related to bindings.
> Bindings describe the hardware.

Indeed, but the key thing here is the WHOAMI register is hardware.

> 
> > I'm not sure how the driver would react to both compatibles being present,
> > and looking at the driver code, it seems that icm20608d is not the only
> > fully icm20608-compatible (to the extent of features supported by
> > the driver, and excluding the WHOAMI value) invensense IC, yet none
> > of these other ICs add the invensense,icm20608 compatible, so I guess I
> > don't see a good reason to do something different.  
> 
> Probably my question should be asked earlier, when these other
> compatibles were added in such way.
> 
> Skipping the DMP core, the new device is fully backwards compatible with
> icm20608.

No. It is 'nearly' compatible...  The different WHOAMI value (used
to check the chip is the one we expect) makes it incompatible.  Now we
could change the driver to allow for that bit of incompatibility and
some other drivers do (often warning when the whoami is wrong but continuing
anyway). 

> Therefore extending the compatible makes sense. This is not
> only correct from devicetree point of view, but also is friendly towards
> out of tree users of bindings.
> 
> The Linux driver behavior about whoami register does not matter here.
> Not mentioning that it would be easy for driver to accept multiple
> values of whoami.

I disagree entirely. Any driver that makes use of the whoami will not
be compatible with this new part.  It's a driver design choice on whether
to make use of that, but it's a perfectly valid one to refuse to probe
if it doesn't detect that the device is the one it expects.
+ There is code out there today doing this so inherently it is not
compatible.

So no, a fall back compatible is not suitable here because it simply
is not compatible.

Now, if intent was to provide a backwards compatible path from this
more advanced part then the behaviour of every register defined for
the simpler part, must be identical on the more advanced part.
Extra functionality could only make use of fields in registers marked
reserved, or of new registers that didn't exist on the simpler device.

There are other ways of handling backwards compatibility but they all
require statements in the simpler device spec about how you can tell
for future more complicated devices that they are compatible with this
spec. E.g. Feature registers, version registers etc.

Jonathan
> 
> 
> Best regards,
> Krzysztof

