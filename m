Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DAC5E638F
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 15:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiIVN1P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 09:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiIVN1M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 09:27:12 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72524E05C5
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 06:27:08 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id d1so6834569qvs.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=GrLIhTlCqGOAs+qMCF4iht+gmyAvzjoR9JcufKCbDCo=;
        b=doTgiqeZ2r9gnGLuQG5ENvnGd53E6H9+d6SIaxf1crfYfRDMZe6s/Tl8hnqZdJw4L1
         1IDyrRwF6OybRNnfwXE6OTkGYL4ygihOy4py+5qKoWmFAFAROquN+tmOwlZkVYn4cCcs
         LgeTUC/DrR3R98TJ/wNnqgVdx5Jjuly0uuRKXhwnc+9VHOdpFBohNMjIl1z3shpClqmk
         mTcr7NL6ac36Q85f4aGGEYGq0kzBUCTHisleFiey7BmUcus+1wGISRu2hp50wcz+v784
         S6OkfT3dzKaubdtQFDWfaLUxC7XUYgSeUgSOLEXfRBE8/6KDDPxsgPgyQR2V9mRnDt37
         LN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GrLIhTlCqGOAs+qMCF4iht+gmyAvzjoR9JcufKCbDCo=;
        b=b6+1nrgOaUecV9wCk/2os+DmjZHmIpO9GPqvf9oBLy1heRE3bPZ8we7+4iKYaYM3AS
         Ol/15XDKzVGNwNwPFAKmzNt8QveK081kKoiy7lz9XXHpxGNRl7+0IpMLXrKb+wvsiAL+
         CxPq2q7ss+cXysefCDDbzs93t/aMIfBDwjwKtw+CNeOoPtL/ZrD07+UQYGJi+TS21bfO
         YsbgvuOgYx+px4oIYp7eHRbombSXaEMqHNfHYIsizDrFIJjpZNB2mlLR8LzGf7Sgy2K3
         XnNMPmraUR0t5waTyAWlEF29QnBfhiYj6157f3nIjNj3479vvof+0czwTwqo8YvjE8Xv
         EX/A==
X-Gm-Message-State: ACrzQf1n1oyphe1j0MtHJqJzfacSoQJtQ0qRksN6zs5Bxin3msST2oq7
        6/2U10WiKqQMSBGIduYrGQfN/GW6mI7a0prsnBI=
X-Google-Smtp-Source: AMsMyM4BHe29X1uzP4ClVPgdGgBnBPa4xOG65Ml6KugR5hE9m+Cn4Fru8QCRSR4GhDqEO3LxX3hXqt7HYjFJ/ByFM2k=
X-Received: by 2002:ad4:5966:0:b0:4ad:7832:a8ec with SMTP id
 eq6-20020ad45966000000b004ad7832a8ecmr2500663qvb.82.1663853227568; Thu, 22
 Sep 2022 06:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220921163620.805879-1-weiyongjun@huaweicloud.com>
 <20220921163620.805879-2-weiyongjun@huaweicloud.com> <20220922054334.a5t6zdxayx2zwjwd@pengutronix.de>
 <20220922121321.000026ea@huawei.com>
In-Reply-To: <20220922121321.000026ea@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 22 Sep 2022 16:26:31 +0300
Message-ID: <CAHp75Vfj_H27eHj-vkbTNJ4x+DVuccZCBRVH47KbBNOBzdntFQ@mail.gmail.com>
Subject: Re: [PATCH 1/5 v3] iio: adc: ti-ads131e08: Silence no spi_device_id warnings
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wei Yongjun <weiyongjun@huaweicloud.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 22, 2022 at 2:13 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Thu, 22 Sep 2022 07:43:34 +0200
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

...

> By providing the new table, non firmware registration paths are enabled
> that were not before (board files + I think Greybus still uses that path?=
)
> If those are used they will get NULL from device_get_match_data() with
> predictable bad results.

We still have some board files or board:ish info in the kernel to
support some platforms, so it won't go away (at least soon: in the
parentheses because don't forget about FPGAs that need a possibility
of the reconfiguration at run time).

--=20
With Best Regards,
Andy Shevchenko
