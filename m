Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19F95F8B58
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 14:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJIMue (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 08:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiJIMu0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 08:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D24127179;
        Sun,  9 Oct 2022 05:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC7D760BFE;
        Sun,  9 Oct 2022 12:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD994C433C1;
        Sun,  9 Oct 2022 12:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665319820;
        bh=pb5ZCQbSkWEPgGcK8oOrtWv5y7chJzNAQxUcdtBBYVI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ur9lPQCVT7StMIYLWN2jDwvGBkgkye0VriKSDE49vOTZboJVGC9z6tHsIQgAPZkTd
         DQh3IkhVEUb5TmGmsryYfvqu5cEzNPZ4td/pAz+teiD6k1kZH1zchG9D2sQGrxCxNg
         9Awb51RxAlBAp25+xFklLYrnfodlpjRrKxTR5VZ6bqpuyWc37/4rQMs+uwQBfV9fK2
         oQih2Z7cO7Em5NyKYzA/tugdk6v3ctZfCgrfInXPHjZvy9bpqFFHQLAq8unJ1vWg2B
         YONGhBzUVK8fyas8CBximg5dO8Ce/f5V177XxlhXtkn4d10V5FI20fZzhhPGiiDxvP
         jboII6xICJwiQ==
Date:   Sun, 9 Oct 2022 13:50:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: change ad5766 maintainer
Message-ID: <20221009135041.5b67913c@jic23-huawei>
In-Reply-To: <166497665565.3275646.2703728693957259548.robh@kernel.org>
References: <20221005085044.204701-1-nuno.sa@analog.com>
        <166497665565.3275646.2703728693957259548.robh@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 5 Oct 2022 08:30:56 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, 05 Oct 2022 10:50:43 +0200, Nuno S=C3=A1 wrote:
> > As the maintainer email no longer exists, change it to myself.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> >  Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >  =20
>=20
> Acked-by: Rob Herring <robh@kernel.org>

Series applied,

Thanks,

Jonathan
