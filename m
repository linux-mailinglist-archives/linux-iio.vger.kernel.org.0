Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECFC368E61
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 10:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhDWIFC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 04:05:02 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:60733 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229982AbhDWIFB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Apr 2021 04:05:01 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.1.92])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 854B6A1CE6C7;
        Fri, 23 Apr 2021 10:04:24 +0200 (CEST)
Received: from localhost (89.70.221.198) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Apr
 2021 10:04:24 +0200
Date:   Fri, 23 Apr 2021 10:00:23 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: core: fix ioctl handlers removal
Message-ID: <YIJ+l4ScIua4RBKt@arch>
References: <20210422201415.46378-1-tomasz.duszynski@octakon.com>
 <CA+U=DsqQUse-cP7k+42reHPYfbAUMTsqLst5--BHKg53FhNbxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CA+U=DsqQUse-cP7k+42reHPYfbAUMTsqLst5--BHKg53FhNbxg@mail.gmail.com>
X-Originating-IP: [89.70.221.198]
X-ClientProxiedBy: DAG2EX2.emp2.local (172.16.2.12) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 9189595042398493949
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdduuddguddvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnheptdehveethfffudetjeeftdekueehjeegjedvteffgfevkefffeegffeugeehgfejnecukfhppedtrddtrddtrddtpdekledrjedtrddvvddurdduleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtoheplhgrrhhssehmvghtrghfohhordguvg
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 23, 2021 at 10:17:42AM +0300, Alexandru Ardelean wrote:
> On Thu, Apr 22, 2021 at 11:26 PM Tomasz Duszynski
> <tomasz.duszynski@octakon.com> wrote:
> >
> > Currently ioctl handlers are removed twice. For the first time during
> > iio_device_unregister() then later on inside
> > iio_device_unregister_eventset() and iio_buffers_free_sysfs_and_mask().
> > Double free leads to kernel panic.
> >
> > Fix this by not touching ioctl handlers list directly but rather
> > letting code responsible for registration call the matching cleanup
> > routine itself.
> >
>
> This change is missing this tag:
>
> Fixes: 8dedcc3eee3ac ("iio: core: centralize ioctl() calls to the main chardev")
>
> With that tag added:
> Acked-by: Alexandru Ardelean <ardeleanalex@gmail.com>
>
> Apologies for the breakage.

No worries. Will append you ack to v2 then.

> Also, I wasn't sure if Jonathan or anyone else wanted to do this change.
>
> Thanks for the patch
> Alex
>
> > Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > ---
> >  drivers/iio/industrialio-core.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index d92c58a94fe4..98944cfc7331 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1939,9 +1939,6 @@ void iio_device_unregister(struct iio_dev *indio_dev)
> >
> >         indio_dev->info = NULL;
> >
> > -       list_for_each_entry_safe(h, t, &iio_dev_opaque->ioctl_handlers, entry)
> > -               list_del(&h->entry);
> > -
> >         iio_device_wakeup_eventset(indio_dev);
> >         iio_buffer_wakeup_poll(indio_dev);
> >
> > --
> > 2.31.1
> >
