Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93188757FB4
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jul 2023 16:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjGROgX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jul 2023 10:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjGROgW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jul 2023 10:36:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADE9FD
        for <linux-iio@vger.kernel.org>; Tue, 18 Jul 2023 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689690934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EhLLlJe15TTGeGNUnSwUWGBDLVxxR5vwYDItCmzrLcY=;
        b=BAGb83wUlz3y9E22OQp8J3JcK8nzDuAiR06G2xWFFOhNQVjZpdcaQzD8sXf0io1y9uCzxw
        yR4Jq70JAnIpbwBgR06XE2whmy9AwFP3fCGelrKYE4JDb00UzXD2Oj7Vj8QnzIDtr6soG1
        rysg7CUZ/fzqjxXqVgby9fQk3iH6YLA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-L1sHR_v8M2K8-XwxtZH8vg-1; Tue, 18 Jul 2023 10:35:26 -0400
X-MC-Unique: L1sHR_v8M2K8-XwxtZH8vg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b704f6bbeaso54562451fa.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Jul 2023 07:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689690920; x=1692282920;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhLLlJe15TTGeGNUnSwUWGBDLVxxR5vwYDItCmzrLcY=;
        b=QvqOfjRmZgZMB475nJWGJoFkPkQHfwSt+v4lxUDyL24uua/+nh0kK0phT8ftAxVQFF
         Y6Tfr1vDJPZbRYHaB3Ydjuh8iyWoHjbo0Ehyt19ZZILkdYZGEFYbhBiGssSGdpEAN0sC
         pnUqlQmRKt5ibdstOpbLA+k5oC5biz8VzTJwLPyZIL2vCYgz9OjN3YK9PG0T/5/oLc1L
         lIvQAxZ5vo4ETrnKG7vJWpRM31RIoKPsTBw/gPWYf+4SKFGcVh9J/o8cjpTfn/jt8O5K
         x36B4ZB8Gn4pYoBns6WsvltUIWsl9XtIbLHpYsEz1vOYgG/I/sMImijykIfMaXrxv+Q6
         zKSQ==
X-Gm-Message-State: ABy/qLby05LEqpnusmMmYYu4VWOcThAhAhrBzZ6ljpQ1ZvfBDduxvifT
        7utwveRMj/ZzPr4kiaOL6/aeMA1GzR6sVxBRhaX94E4mDVe7JKcjKhWDIc2syZbV3IMtcZ3aUFW
        yggfZGPWaybplMzV1Iltf
X-Received: by 2002:a2e:868e:0:b0:2b8:377a:22f1 with SMTP id l14-20020a2e868e000000b002b8377a22f1mr9986043lji.32.1689690920142;
        Tue, 18 Jul 2023 07:35:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFh3f5eIawq1YhuGmmxtzjX/DeBV50+gIIA66BFvkRE+KbRquEb54gkOF2kq30UeW3hYmvAvw==
X-Received: by 2002:a2e:868e:0:b0:2b8:377a:22f1 with SMTP id l14-20020a2e868e000000b002b8377a22f1mr9986025lji.32.1689690919757;
        Tue, 18 Jul 2023 07:35:19 -0700 (PDT)
Received: from nuthatch (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709063e4700b0098f99048053sm1115217eji.148.2023.07.18.07.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 07:35:19 -0700 (PDT)
From:   Milan Zamazal <mzamazal@redhat.com>
To:     Nuno =?utf-8?Q?S=C3=A1?= <noname.nuno@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] iio: core: Prevent invalid memory access when there is
 no parent
References: <20230718120700.132579-1-mzamazal@redhat.com>
        <4a5d6ca0e2c9529d5eb0bbacbaed56e2645719c6.camel@gmail.com>
Date:   Tue, 18 Jul 2023 16:35:18 +0200
In-Reply-To: <4a5d6ca0e2c9529d5eb0bbacbaed56e2645719c6.camel@gmail.com>
 ("Nuno
        =?utf-8?Q?S=C3=A1=22's?= message of "Tue, 18 Jul 2023 15:10:07 +0200")
Message-ID: <87lefdcmop.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Nuno S=C3=A1 <noname.nuno@gmail.com> writes:

> On Tue, 2023-07-18 at 14:07 +0200, Milan Zamazal wrote:
>> Commit 813665564b3d ("iio: core: Convert to use firmware node handle
>> instead of OF node") switched the kind of nodes to use for label
>
>> retrieval in device registration.=C2=A0 Probably an unwanted change in t=
hat
>> commit was that if the device has no parent then NULL pointer is
>> accessed.=C2=A0 This is what happens in the stock IIO dummy driver when a
>> new entry is created in configfs:
>>=20
>> =C2=A0 # mkdir /sys/kernel/config/iio/devices/dummy/foo
>> =C2=A0 BUG: kernel NULL pointer dereference, address: 0000000000000278
>> =C2=A0 ...
>> =C2=A0 ? asm_exc_page_fault+0x22/0x30
>> =C2=A0 ? container_offline+0x20/0x20
>> =C2=A0 __iio_device_register+0x45/0xc10
>> =C2=A0 ? krealloc+0x73/0xa0
>> =C2=A0 ? iio_device_attach_buffer+0x31/0xc0
>> =C2=A0 ? iio_simple_dummy_configure_buffer+0x20/0x20
>> =C2=A0 ? iio_triggered_buffer_setup_ext+0xb4/0x100
>> =C2=A0 iio_dummy_probe+0x112/0x190
>> =C2=A0 iio_sw_device_create+0xa8/0xd0
>> =C2=A0 device_make_group+0xe/0x40
>> =C2=A0 configfs_mkdir+0x1a6/0x440
>>=20
>> Since there seems to be no reason to make a parent device of an IIO
>> dummy device mandatory, let=E2=80=99s prevent the invalid memory access =
in
>> __iio_device_register when the parent device is NULL.=C2=A0 With this
>> change, the IIO dummy driver works fine with configfs.
>>=20
>> Fixes: 813665564b3d ("iio: core: Convert to use firmware node handle ins=
tead
>> of OF node")
>> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
>> ---
>
> LGTM (just one minor question below...)
>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>
>> =C2=A0drivers/iio/industrialio-core.c | 11 ++++++-----
>> =C2=A01 file changed, 6 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-=
core.c
>> index c117f50d0cf3..229527b3434a 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -1888,7 +1888,7 @@ static const struct iio_buffer_setup_ops
>> noop_ring_setup_ops;
>> =C2=A0int __iio_device_register(struct iio_dev *indio_dev, struct module=
 *this_mod)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_dev_opaque *i=
io_dev_opaque =3D to_iio_dev_opaque(indio_dev);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct fwnode_handle *fwnode;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct fwnode_handle *fwnode =
=3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!indio_dev->info)
>> @@ -1899,11 +1899,12 @@ int __iio_device_register(struct iio_dev *indio_=
dev,
>> struct module *this_mod)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* If the calling driver=
 did not initialize firmware node, do it here
>> */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dev_fwnode(&indio_de=
v->dev))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0fwnode =3D dev_fwnode(&indio_dev->dev);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (indio_dev->dev.paren=
t !=3D NULL)
>
> Maybe this is odd enough that it could have an explicit comment referenci=
ng the
> iio-dummy device?=20

Good idea, also to not forget about iio-dummy generally.  I'll add it.

> Not sure if there's any other place where this can actually happen...
>
> Apparently there are also some dev_err() on the parent device (even though
> dev_err() handles it) but yeah, unrelated with this.
>
>
> - Nuno S=C3=A1

