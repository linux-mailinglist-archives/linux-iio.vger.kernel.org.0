Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DF378B150
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 15:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjH1NG5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 09:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjH1NG2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 09:06:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF81C9;
        Mon, 28 Aug 2023 06:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ADB661610;
        Mon, 28 Aug 2023 13:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9C0C433C7;
        Mon, 28 Aug 2023 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693227985;
        bh=DLJyKtc8ddZXC6U44eDu9so7ihqSFYcaRLfqHNpU0KI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZNtcgvEPacVwzngdOBY+iz+s2ABCI5DkesywVD9bwcNU0w0nrsk6Mu+KlzHuRgLPU
         tlcIHoOr1+9VFVmpiydkLYF4Ba8urbFXGrkZBr/gt2DHemN4hrB1YAw40uPz0ss5oQ
         5uIZSpFbx3o4/gxHWPFUByH8reOVhYA5QqSJATPVKywkva6VEIhnh+OGNPlr7V+VNC
         2mQvVNhqPshk3XiBitMr7EkiDBbVEb/UJwxxzumLZtAjn+CxqeSKdim8g85u5V99Dc
         aEkjyxZ1fh//sTIbaUIcVJiKN7UkDD+VHmPneHrcpIPaZWE/2lua0+heCuhm1zrEp/
         1vnkcGzQw8J1w==
Date:   Mon, 28 Aug 2023 14:06:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andi Shyti <andi.shyti@kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Crt Mori <cmo@melexis.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: ak8975: Simplify probe()
Message-ID: <20230828140644.25688542@jic23-huawei>
In-Reply-To: <ZNI9rIWa7bxNW9+P@smile.fi.intel.com>
References: <20230807172548.258247-1-biju.das.jz@bp.renesas.com>
        <20230807172548.258247-2-biju.das.jz@bp.renesas.com>
        <ZNI9rIWa7bxNW9+P@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Aug 2023 16:05:48 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Aug 07, 2023 at 06:25:48PM +0100, Biju Das wrote:
> > Simplify the probe() by replacing device_get_match_data() and
> > i2c_client_get_device_id by i2c_get_match_data() as we have similar I2C,
> > ACPI and DT matching table.  
> 
> ...
> 
> > -		name = dev_name(&client->dev);  
> 
> > -		name = id->name;  
> 
> > -	indio_dev->name = name;
> > +	indio_dev->name = dev_name(&client->dev);  
> 
> I believe this is an ABI breakage.

Using dev_name(&client->dev) was an old bug but we missed it
in a few drivers for long enough that we didn't want to risk
breaking userspace by fixing it :( 

With hindsight we should have added more comments to the code
though so people would know to beware.

Jonathan

> 
> NAK.
> 

