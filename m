Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D611F577036
	for <lists+linux-iio@lfdr.de>; Sat, 16 Jul 2022 19:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiGPRAQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Jul 2022 13:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiGPRAP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jul 2022 13:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75B71F631;
        Sat, 16 Jul 2022 10:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3970A611C6;
        Sat, 16 Jul 2022 17:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5049C34115;
        Sat, 16 Jul 2022 17:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657990813;
        bh=CnAAGYOm+JIQMwBHp2gppTxngw1c5UKaeltps1qf9ks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J2uC4SxZveTw+7G0OL3Vc8Fbwyz+Vf1caFzw07bVGqeXvzqMrGI1FzLK6qixI5Jj7
         VDcTkJf7IV3xs9VZf95Z5g4hn0F+RL4bfsriQfbtrUtJXq2gDIwkOa8TOhB1U8D7P5
         6LDNxgJgq/7z6cJMO+S/IN0yx8RVWpDbQzKRd+NQLaYUmU8KZCopuZjQbXyKnsPol6
         OkpeXcTsvRx+nO3nrBS5Gyv4SQlOR7+hFaK6uvTYpzEgxJ8AYt3wxEFzJfrMPbLcII
         HKxE95YYYled6piApGZsUw+9FOYnaiWkN17sE7aN7vU/CWrBMwlxb5wPXwQUsRvsSI
         YuS8aUgIac2wQ==
Date:   Sat, 16 Jul 2022 18:10:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jakob Hauser <jahau@rocketmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 09/10] iio: magnetometer: yas530: Introduce
 "chip_info" structure
Message-ID: <20220716181005.7029250c@jic23-huawei>
In-Reply-To: <CAHp75VfGqk_q1iDyj06tEuTNoG35xjOL0_5HgokFauUz_aAwFQ@mail.gmail.com>
References: <cover.1656883851.git.jahau@rocketmail.com>
        <28a2a9ec27c6fb4073149b897415475a8f04e3f7.1656883851.git.jahau@rocketmail.com>
        <CAHp75VfGqk_q1iDyj06tEuTNoG35xjOL0_5HgokFauUz_aAwFQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Jul 2022 21:37:30 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Jul 4, 2022 at 12:04 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> >
> > This commit introduces the "chip_info" structure approach for better variant
> > handling.
> >
> > The variant to be used is now chosen by the devicetree (enum "chip_ids"),  
> 
> Device Tree
> 
> > not by the chip ID in the register. However, there is a check to make sure
> > they match (using integer "id_check").  
> 
> ...
> 
> Thanks for a new version, it's getting better. My comments below.
> 
> But first of all, can you split this to at least two patches, i.e.
> 1) split out functions without introducing chip->info yet;
> 2) adding chip_info.
> 
> Possible alternative would be more steps in 2), i.e. introducing
> chip_info for the callback only, then add field (or semantically
> unified fields) by field with corresponding changes in the code. In
> this case it would be easier to review.
> 
> I leave this exercise to you if Jonathan thinks it worth it.

You are of course correct that it would be nicer to have it split, but
I'm not going to be fussy about it this time ;)

Other than addressing Andy's eagle eyed review comments, this series looks good to me.

Thanks,

Jonathan

