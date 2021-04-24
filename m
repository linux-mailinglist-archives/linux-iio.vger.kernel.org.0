Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E9536A112
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 14:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhDXMOW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 08:14:22 -0400
Received: from smtpout1.mo3004.mail-out.ovh.net ([79.137.123.219]:39635 "EHLO
        smtpout1.mo3004.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231836AbhDXMOU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Apr 2021 08:14:20 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.143.176])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 99D6723D114;
        Sat, 24 Apr 2021 12:13:39 +0000 (UTC)
Received: from localhost (89.70.221.198) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 24 Apr
 2021 14:13:39 +0200
Date:   Sat, 24 Apr 2021 14:09:36 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <ardeleanalex@gmail.com>
Subject: Re: [PATCH v2] iio: core: fix ioctl handlers removal
Message-ID: <YIQKgLtdUlSHsJXu@arch>
References: <20210423080244.2790-1-tomasz.duszynski@octakon.com>
 <20210424115250.14d21a71@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210424115250.14d21a71@jic23-huawei>
X-Originating-IP: [89.70.221.198]
X-ClientProxiedBy: CAS2.emp2.local (172.16.1.2) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 825003158838008914
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvddugedgheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkfhggtggujghisehttdortddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnhepkeejgfevledtgfdtfeettdektedvieeiveduueetudekieetiedujedtleevleelnecukfhppedtrddtrddtrddtpdekledrjedtrddvvddurdduleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtoheprghruggvlhgvrghnrghlvgigsehgmhgrihhlrdgtohhm
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 24, 2021 at 11:52:50AM +0100, Jonathan Cameron wrote:
> On Fri, 23 Apr 2021 10:02:44 +0200
> Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:
>
> > Currently ioctl handlers are removed twice. For the first time during
> > iio_device_unregister() then later on inside
> > iio_device_unregister_eventset() and iio_buffers_free_sysfs_and_mask().
> > Double free leads to kernel panic.
> >
> > Fix this by not touching ioctl handlers list directly but rather
> > letting code responsible for registration call the matching cleanup
> > routine itself.
> >
> > Fixes: 8dedcc3eee3ac ("iio: core: centralize ioctl() calls to the main chardev")
> > Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > Acked-by: Alexandru Ardelean <ardeleanalex@gmail.com>
>
> There are a bunch of unused local variables as a result of this change
> (build warnings on my standard W=1 C=1 test).  I've dropped those as well and
> applied this to the fixes-togreg branch of iio.git.
>

Right, thanks for catching this.

> We are a bit unfortunate on timing for this as I won't send a pull request
> for fixes until towards the end of the merge window.  I've marked it for stable
> though so it should filter back fairly quickly so kernels people actually
> use.
>
> Thanks,
>
> Jonathan
>
> > ---
> > v2:
> > * add fixes tag and ack
> >
> >  drivers/iio/industrialio-core.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index d92c58a94fe4..98944cfc7331 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1939,9 +1939,6 @@ void iio_device_unregister(struct iio_dev *indio_dev)
> >
> >  	indio_dev->info = NULL;
> >
> > -	list_for_each_entry_safe(h, t, &iio_dev_opaque->ioctl_handlers, entry)
> > -		list_del(&h->entry);
> > -
> >  	iio_device_wakeup_eventset(indio_dev);
> >  	iio_buffer_wakeup_poll(indio_dev);
> >
> > --
> > 2.31.1
> >
>
