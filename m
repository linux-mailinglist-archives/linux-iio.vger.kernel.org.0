Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876D470A940
	for <lists+linux-iio@lfdr.de>; Sat, 20 May 2023 18:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjETQiE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 May 2023 12:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETQiE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2023 12:38:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354458E
        for <linux-iio@vger.kernel.org>; Sat, 20 May 2023 09:38:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B377960AE9
        for <linux-iio@vger.kernel.org>; Sat, 20 May 2023 16:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2243CC433D2;
        Sat, 20 May 2023 16:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684600682;
        bh=CKIQD8S6plhOkHG0nQvcr0gSePKW5DkGIheA4lsWGKM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pzRKQxbvZInoKYVymbpJqKQ8/KD08LQWEIu86kxDt7CU/hwhgE89UOwYerXjDeMC0
         H7e8VkOX6DmX5fuk6CnG9qrlvdVLq0lHuBDv9+lhiq3KIeUlRl69/uLN2ZhJweN564
         YyMalcJqtdKOnzx2/6GluAQO5utcCV9IZDg/H4YEp+Sms5kVFqSSL01NERCYrksFmY
         D8esyuPY5NcC093DM9r3QBY/XymoJGgSO7kjg+qBcqqH5LZp1GJrodoI8uj2xUX/0i
         OE+I/3LV7UMN9k+9W6OS+xec1+Kcs+oKCgvjCxdn5MLCavtdxk1C+zgAasPT6H5VIe
         nWSDuYXT0RpDg==
Date:   Sat, 20 May 2023 17:54:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] iio: Switch i2c drivers back to use .probe()
Message-ID: <20230520175411.790a4dd2@jic23-huawei>
In-Reply-To: <20230520164340.25360292@jic23-huawei>
References: <20230515205048.19561-1-u.kleine-koenig@pengutronix.de>
        <20230520164340.25360292@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 20 May 2023 16:43:40 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 15 May 2023 22:50:48 +0200
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> > call-back type"), all drivers being converted to .probe_new() and then
> > 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") conve=
rt
> > back to (the new) .probe() to be able to eventually drop .probe_new() f=
rom
> > struct i2c_driver.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =
=20
> Some fuzz due to other patches being queued up already, but otherwise
> LGTM and applied to the togreg branch of iio.git which is initially pushed
> out as testing for 0-day to give it a whirl.
>=20
> Thanks,
>=20
> Jonathan

I'm seeing some bounces due to size of email.=20

It's in the testing branch of iio.git if anyone wants to see what was in th=
is patch!

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=3Dt=
esting&id=3Dbe8e2ed93211e39a2b70e8a3f268beefd517d222
