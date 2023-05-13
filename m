Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8331E701934
	for <lists+linux-iio@lfdr.de>; Sat, 13 May 2023 20:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjEMSb2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 May 2023 14:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEMSb1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 May 2023 14:31:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8038D1BC2
        for <linux-iio@vger.kernel.org>; Sat, 13 May 2023 11:31:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14D7260FD4
        for <linux-iio@vger.kernel.org>; Sat, 13 May 2023 18:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C828FC433EF;
        Sat, 13 May 2023 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684002685;
        bh=2xVoTsiMdwT+i8D1dcE0onp7Ad+7AxYx40NgMhwzOq8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F4D4efWtasa3hYEHa0Q2XS6G4Az1yo1nEntMNMiY6wckAKQXZXnPHM4L8YH6oPjOu
         r2vn805Sn2rVZtbAPlYSZ1XOJl9DN4960FiVptin5N7O9CChPX0BVRMsTbShXv6Jzi
         Hw4oshw0llBrNaZOtwl1T4IVklqLJxeJQvY/SO2uucpKFhXZjRkigXLaUBwFphR5Yo
         /Lr9l45+J/WQRHTTIIuNL1PQa4XUebYWaJ5RkKT0swzTR4ut/Ke6TXWKtWvR6ByJRS
         41ay5yo3FAaQzMx3x9Z1paM+GKR/xgnpMKPwr+6zk+ZjqzVjdAWAzV5NHtc5P5AZdx
         NlMrnNyktGD/g==
Date:   Sat, 13 May 2023 19:47:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
        Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH] iio: dac: mcp4725: Fix i2c_master_send() return value
 handling
Message-ID: <20230513194726.56083288@jic23-huawei>
In-Reply-To: <20230511061521.ri6gnymsasnrpde2@pengutronix.de>
References: <20230511004330.206942-1-marex@denx.de>
        <20230511061521.ri6gnymsasnrpde2@pengutronix.de>
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

On Thu, 11 May 2023 08:15:21 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> On Thu, May 11, 2023 at 02:43:30AM +0200, Marek Vasut wrote:
> > The i2c_master_send() returns number of sent bytes on success,
> > or negative on error. The suspend/resume callbacks expect zero
> > on success and non-zero on error. Adapt the return value of the
> > i2c_master_send() to the expectation of the suspend and resume
> > callbacks, including proper validation of the return value.
> >=20
> > Fixes: cf35ad61aca2 ("iio: add mcp4725 I2C DAC driver")
> > Signed-off-by: Marek Vasut <marex@denx.de> =20
>=20
> Makes sense,
>=20
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied to the fixes-togreg branch of iio.git and marked for
stable inclusion

Thanks,

Jonathan

>=20
> Best regards
> Uwe
>=20

