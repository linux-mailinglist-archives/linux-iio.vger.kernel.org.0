Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE254EC471
	for <lists+linux-iio@lfdr.de>; Wed, 30 Mar 2022 14:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243656AbiC3Mjx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Mar 2022 08:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243925AbiC3Mhk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Mar 2022 08:37:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF5AABF5B
        for <linux-iio@vger.kernel.org>; Wed, 30 Mar 2022 05:27:49 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KT5J20pXnz67qQW;
        Wed, 30 Mar 2022 20:25:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 30 Mar 2022 14:27:46 +0200
Received: from localhost (10.47.70.51) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 30 Mar
 2022 13:27:46 +0100
Date:   Wed, 30 Mar 2022 13:27:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: updated Lorenzo's email address
Message-ID: <20220330132742.00005e12@Huawei.com>
In-Reply-To: <CAHp75VdpgB4xveRkmGAHEnYoEeiMUOL8J0NoovsXhuskwiwvtg@mail.gmail.com>
References: <c75f0e1c683b6ad0333d5504fb00c6f1b14dd1bf.1648114531.git.lorenzo@kernel.org>
        <20220327153555.289eddf4@jic23-huawei>
        <CAHp75VdpgB4xveRkmGAHEnYoEeiMUOL8J0NoovsXhuskwiwvtg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.70.51]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Mar 2022 22:38:49 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Mar 27, 2022 at 10:36 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Thu, 24 Mar 2022 12:05:43 +0100
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >  
> > > Using my kernel.org email for iio devices.  
> 
> > Applied.  
> 
> I'm wondering all those email changes in the MAINTAINERS, are they
> being accompanied with the .mailcap changes?
> It would be good to have this done in order to decrease the amount of
> (email) bounces.
> OTOH dunno if get_maintainer.pl looks into .mailcap.
>

I'll guess, but in this case I think Lorenzo only wants to direct
mails about 'some' of the stuff he maintains to his kernel.org
account (as it's the stuff not related to the day job any more).
Hence for this one .mailmap change probably doesn't make sense.

Jonathan


