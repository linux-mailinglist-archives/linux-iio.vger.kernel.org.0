Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E1070F417
	for <lists+linux-iio@lfdr.de>; Wed, 24 May 2023 12:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjEXKZK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 May 2023 06:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjEXKZG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 May 2023 06:25:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D01BC0;
        Wed, 24 May 2023 03:25:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DBAB9223E1;
        Wed, 24 May 2023 10:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684923903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7R/1ArihqwMpzWpgH+6nEfGggJF2LepLDRDMiCWbzM=;
        b=Z4qDYRqPTzy6KC0PYLAQ2SOXgqESlAUv8Vzmyxqz181Uh8HcHmPWJSZ4C3s+6b/ItYg+HF
        baNQIfFtChA4t5tH7LFXk+zo9OcPbekju+/jKqnr1cOdQEhIBxc+pR2SfswjuHDlhHdjMK
        I4DpHmGdNzxwz14+8UYpsneDbdqptlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684923903;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7R/1ArihqwMpzWpgH+6nEfGggJF2LepLDRDMiCWbzM=;
        b=7s9Z3KsnYonlXDJmh/B+XR5J6gMzbsLapAx0f+eO+snnD6gLlFh3Iphei8G6XjkZMWcSvV
        X6e9fqoz7CwlxJCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0287313425;
        Wed, 24 May 2023 10:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /+2+Ov7lbWRXIQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Wed, 24 May 2023 10:25:02 +0000
Date:   Wed, 24 May 2023 12:25:01 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= 
        <niklas.soderlund@ragnatech.se>,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wolfram Sang <wsa@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Kalle Valo <kvalo@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Crt Mori <cmo@melexis.com>, Haowen Bai <baihaowen@meizu.com>,
        Tom Rix <trix@redhat.com>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        kernel@pengutronix.de, linux-media@vger.kernel.org
Subject: Re: [PATCH] staging: Switch i2c drivers back to use .probe()
Message-ID: <20230524122501.33c46d6f@endymion.delvare>
In-Reply-To: <20230523200036.465180-1-u.kleine-koenig@pengutronix.de>
References: <20230523200036.465180-1-u.kleine-koenig@pengutronix.de>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 May 2023 22:00:36 +0200, Uwe Kleine-K=C3=B6nig wrote:
> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") convert
> back to (the new) .probe() to be able to eventually drop .probe_new() from
> struct i2c_driver.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> this patch was generated using coccinelle.
>=20
> I chose to convert all drivers below drivers/staging in a single
> patch, but if you prefer I can split by driver.
>=20
> If conflicts arise until this is applied, feel free to just drop the
> files with conflicts from this patch. I'll care about the fallout later
> then.
>=20
> Also note there is no coordination necessary with the i2c tree. Dropping
> .probe_new() will happen only when all (or most) drivers are converted,
> which will happen after v6.5-rc1 for sure.
>=20
> Best regards
> Uwe
>  drivers/staging/iio/addac/adt7316-i2c.c                   | 2 +-
>  drivers/staging/iio/impedance-analyzer/ad5933.c           | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-gc0310.c        | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-gc2235.c        | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-lm3554.c        | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c       | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-ov2680.c        | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-ov2722.c        | 2 +-
>  drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c | 2 +-
>  drivers/staging/media/max96712/max96712.c                 | 2 +-
>  drivers/staging/most/i2c/i2c.c                            | 2 +-
>  drivers/staging/olpc_dcon/olpc_dcon.c                     | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

--=20
Jean Delvare
SUSE L3 Support
