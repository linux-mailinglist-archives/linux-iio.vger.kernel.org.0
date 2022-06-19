Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66DF5509D5
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 12:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiFSKth (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 06:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiFSKte (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 06:49:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE87F586;
        Sun, 19 Jun 2022 03:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 067BAB80BA0;
        Sun, 19 Jun 2022 10:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA75C34114;
        Sun, 19 Jun 2022 10:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655635768;
        bh=ml8xzfS/4s43QQV6uviKGJHvPVeDaTAIYELUeCzvLgQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iYwwMBfyDQm0f6hP6GWsi0fTaNMVBwjaQyAC9ffT5LXRNPh87AyacMSZQ1cviJUKO
         U0QupP6B7PkLQCztJ8acMXfDBobwVkGOOndhMrK7kp32Xf1wPqBcUSnEVCkuRYYv97
         4Rrwz2cGasqjZ6qZL4xz6uBAoyCzzxAFysolMk9XFf42tCiOWVbZDMXaeRCSlBsDWi
         luah1NVLlaRHYDopV8wohsVv2lCuOq0V/kIcoTydfuQi+3kZFqzSfXfnZGiLVYA8o0
         1QOiSQkwSke8hugpr2S5uK1k0rYasiAVXDFq5w+Q9byK1uEOEgR3Fln6/KWZgNg27U
         6QDvPFDIK8s5w==
Date:   Sun, 19 Jun 2022 11:58:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jakob Hauser <jahau@rocketmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 8/8] iio: magnetometer: yas530: Add YAS537 variant
Message-ID: <20220619115846.7d6a8393@jic23-huawei>
In-Reply-To: <CAHp75VemByhNAYGuP2h-5HazPZL7k5tyGc1WV2gKEdjX_5Sing@mail.gmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
        <3bdb392bb75073bdfe10aab1739fee2d6c64f10c.1655509425.git.jahau@rocketmail.com>
        <20220618162833.218dbe67@jic23-huawei>
        <CAHp75VemByhNAYGuP2h-5HazPZL7k5tyGc1WV2gKEdjX_5Sing@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 19 Jun 2022 12:32:56 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Jun 18, 2022 at 5:19 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sat, 18 Jun 2022 02:13:16 +0200
> > Jakob Hauser <jahau@rocketmail.com> wrote:  
> 
> ...
> 
> > > +             for (i = 0; i < 17; i++) {  
> >
> > Reduce indent by doing this as multiple loops.
> > Though even better if you can use bulk writes.
> >
> >                 int j = 0;
> >                 for (i = 0; i < 12; i++) {
> >                         ret = regmap_write(yas5xx->map, YAS537_MTC + i,
> >                                            data[j++])
> >                         if (ret)
> >                                 return ret;
> >                 }
> >
> >                 for (i = 0; i < 4; i++) {
> >                         ret = regmap_write(yas5xx->map, YAS573_OFFSET_X + i,
> >                                            data[j++]);
> >                         if (ret)
> >                                 return ret;
> >                 }  
> 
> I guess you are referring to _noinc variants of regmap bulk operations.
Hi Andy,

No. These seem to be incrementing the register address, so you don't want the _noinc
variant as far as I can see.

> 
> > > +                     if (i < 12) {
> > > +                             ret = regmap_write(yas5xx->map,
> > > +                                                YAS537_MTC + i,
> > > +                                                data[i]);
> > > +                             if (ret)
> > > +                                     return ret;
> > > +                     } else if (i < 15) {
> > > +                             ret = regmap_write(yas5xx->map,
> > > +                                                YAS537_OFFSET_X + i - 12,
> > > +                                                data[i]);
> > > +                             if (ret)
> > > +                                     return ret;
> > > +                             yas5xx->hard_offsets[i - 12] = data[i];
> > > +                     } else {
> > > +                             ret = regmap_write(yas5xx->map,
> > > +                                                YAS537_HCK + i - 15,
> > > +                                                data[i]);
> > > +                             if (ret)
> > > +                                     return ret;
> > > +                     }
> > > +             }  
> 

