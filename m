Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FC04C56CD
	for <lists+linux-iio@lfdr.de>; Sat, 26 Feb 2022 17:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiBZQam (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Feb 2022 11:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiBZQam (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Feb 2022 11:30:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1A421F5F6;
        Sat, 26 Feb 2022 08:30:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65371B80834;
        Sat, 26 Feb 2022 16:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E59C340E8;
        Sat, 26 Feb 2022 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645893005;
        bh=LArHDKqTDNk68HFLD/iXZWZLZxUBG0WfF5GvSs+rysg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eNZVG3QVnxDnGp4Vp2FuvwUfFFw7srkkcBnyeoJvoUL+f2TfvYSVA5bdUC+vBIcjW
         cT5f3Jwg4GY4NVYUf855E/MBw7MHECxbiNQ8j8ZoVj9R+VM8hibYbrZn22coFbG/0t
         WM0JMioH8lgo7Q5jb1mmdiyCUnZVnSFkLPj4NkWzNtk32O1ntvVK7gH24ASbsSxLcp
         Qhg1XYqfT7yuouLGoXVZWwiQyZvKD0DiYsXhiK8agp7JPV9NxXVINmjVS4Jxff00vO
         ysufZzOpWTNXVdy21viNJA4OapASwaS8L2n0nu6ABnBBBJUO/yGYpM8z8BajR3qLeG
         zzPkZL/V3Vq7Q==
Date:   Sat, 26 Feb 2022 16:37:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] dt-bindings: iio: dac: adi,ad5755: drop unrelated
 included.
Message-ID: <20220226163706.4ae6ef41@jic23-huawei>
In-Reply-To: <a6e5bb87-21e7-866e-ee9b-646fcf80956b@geanix.com>
References: <20211204165817.2768110-1-jic23@kernel.org>
        <a6e5bb87-21e7-866e-ee9b-646fcf80956b@geanix.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Feb 2022 13:37:24 +0100
Sean Nyekjaer <sean@geanix.com> wrote:

> On 04/12/2021 17.58, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Probably a cut and paste error, but the binding header used in the
> > example is for the wrong device and nothing from it is used.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>  
> 
> Hi Joanthan,
> 
> Sorry for not seeing this :)
> I hope I have updated the mailmap correctly to reflect this email address.
> 
Lazy me didn't check :( 

Sorry!

Jonathan

> Br,
> Sean

