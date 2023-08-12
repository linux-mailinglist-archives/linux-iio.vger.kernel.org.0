Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A69077A0FF
	for <lists+linux-iio@lfdr.de>; Sat, 12 Aug 2023 18:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjHLQWI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Aug 2023 12:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHLQWH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 12:22:07 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7B310EB;
        Sat, 12 Aug 2023 09:22:10 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0835A8611E;
        Sat, 12 Aug 2023 18:22:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1691857327;
        bh=e1Ld3BbnsTMPlAUnXf8LOo6b9irRXiPTEBS71NdvL0E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mH6xleQcGKMq6dnLGcLqfiI1AOl8c3D/5ivwXwKlYqFXh3WBmXd4MsoEf9j6N/Pny
         9yNLzKF9nV56WJwyTYxNGBHeQ/EHJPprBZvNmxp2X+Jp+NzOTq/51HP1WL/9/PCRRL
         XK7kmy58Hdi6V/AWqlkpZcR3AI1H0Ezoj53vnh3tqEGeOwSIm2qwMdKEprR4Xb7xcs
         1FPn/j4DHE9cd9Ivo07NpiqWj5+Sup5Bq6Fufkg7gdSypzHV6jtX3irzg+WoLVeIc2
         7jdE3S+rN+xFIs2XYpuiufbGtE5DLL3JDQHk4eDODIoLgbPtUBYEJA+WnPACQ9Ek5O
         9Vl56QRHTw2qg==
Message-ID: <9545092d-fd45-6122-d2d6-4d390031f85f@denx.de>
Date:   Sat, 12 Aug 2023 18:18:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] iio: dac: mcp4725: Replace variable 'id' from struct
 mcp4725_data
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
References: <20230812115449.89942-1-biju.das.jz@bp.renesas.com>
 <20230812115449.89942-2-biju.das.jz@bp.renesas.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230812115449.89942-2-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/12/23 13:54, Biju Das wrote:
> Replace the variable 'id' from struct mcp4725_data with local variable
> chip_id in probe().

... because the id variable is not used elsewhere in the driver ?

It probably makes sense to add the reasoning into the commit message.
