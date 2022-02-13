Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E4D4B3C4D
	for <lists+linux-iio@lfdr.de>; Sun, 13 Feb 2022 17:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiBMQtU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Feb 2022 11:49:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiBMQtU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Feb 2022 11:49:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBCC5B3F9;
        Sun, 13 Feb 2022 08:49:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EFEAB80886;
        Sun, 13 Feb 2022 16:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F78FC004E1;
        Sun, 13 Feb 2022 16:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644770951;
        bh=KaL0kUvYo90UUMVofBczF9tgkvg1Kbt1TiJGxmg7TQo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CrZo+Gsi3CwxXTO0XLP7z9sPmFWwMJO0S4S6SR9HZSm/nQPlPL/eRvZXJyU+HBZ8Q
         aXYHLTWS5CMqPAzIychVEMspyEx974I+fPwFxr0/DqTDsOC6e3vonPrIs7sv5Skm1x
         4cVb0vYmaekQCbPWT5YJkwosXsDN7GwtF4NeIhpmORYvLSHgNx4k+mv8DwHMOuTA8e
         R1vfbxDd34xN9wh9XtHgWtKROJ01F8bjcsgnyJZ/btjLktYSWnHydJQ8FmpJk/9vaX
         InHa5Hy5HdFcgyioVgjx1XrX3V/w+M8+5LRCVfigVv/pF5zU3D2T59maCEIzCFSo+a
         6EPX41RwG+tbw==
Date:   Sun, 13 Feb 2022 16:55:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org
Subject: Re: [PATCH v4 1/8] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Message-ID: <20220213165550.13051272@jic23-huawei>
In-Reply-To: <20220211211959.502514-2-caleb.connolly@linaro.org>
References: <20220211211959.502514-1-caleb.connolly@linaro.org>
        <20220211211959.502514-2-caleb.connolly@linaro.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Feb 2022 21:19:52 +0000
Caleb Connolly <caleb.connolly@linaro.org> wrote:

> Some PMIC functions such as the RRADC need to be aware of the PMIC
> chip revision information to implement errata or otherwise adjust
> behaviour, export the PMIC information to enable this.
> 
> This is specifically required to enable the RRADC to adjust
> coefficients based on which chip fab the PMIC was produced in,
> this can vary per unique device and therefore has to be read at
> runtime.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Hi Caleb,

Looks fine to me, though obviously needs a tag from Lee as MFD maintainer.
I'm assuming I'll take this series through IIO once everyone is happy
with the changes and hence it'll pick up my SoB, so I'm not giving
RBs or similar in the meantime.

Thanks,

Jonathan
