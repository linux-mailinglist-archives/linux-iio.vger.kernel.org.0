Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49FF754A40
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jul 2023 18:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjGOQ4a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jul 2023 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGOQ43 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jul 2023 12:56:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F545FD;
        Sat, 15 Jul 2023 09:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13DB060BC1;
        Sat, 15 Jul 2023 16:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED3EC433C8;
        Sat, 15 Jul 2023 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689440187;
        bh=j/X9HRq0NyQ4TPbLatI7AanH8hVgXhQxEBtgYHZrvtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WLzOSMOdM44mfL5kBzIcDEDGoVjKLBznKxpV0f9t1pKPr4fGqgWst/nE+SffYVFzJ
         ecp1J7ClSaeYBkpP9Xql0YBcm2Ysrgq1WZ9BCYtWVBYUVFt+5vdj28LpHdOzt4XMRC
         7h5hIUPFYZmrZwmnr08FoRvo92K+AwgLdhoFRlA8Wxiu/2nrfgozwMFItX3lzZCgZ0
         uIUp+8KRHfjZnXUCErK23UhwD6s0bRwQpr/VcsjVl3K8hJuTtYWHbcXsRG8gJdgHis
         w42MPuXFXmkGUxUki4i790/uMkhIcJRfQDdWiGPp1Y6QUw6qy+qltI5CvkRl9evJJQ
         O0tmUoHRdO6aA==
Date:   Sat, 15 Jul 2023 17:56:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/8] dt-bindings: iio: adc: qcom,spmi-adc7: use
 predefined channel ids
Message-ID: <20230715175618.10f00d48@jic23-huawei>
In-Reply-To: <e8700bea-73d5-8ca2-9517-737c13ad3679@linaro.org>
References: <20230707123027.1510723-1-dmitry.baryshkov@linaro.org>
        <20230707123027.1510723-2-dmitry.baryshkov@linaro.org>
        <e8700bea-73d5-8ca2-9517-737c13ad3679@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Jul 2023 11:03:04 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 07/07/2023 14:30, Dmitry Baryshkov wrote:
> > Each of qcom,spmi-adc7-pm*.h headers define a set of ADC channels that
> > can be used for monitoring on thie particular chip. Switch them to use
> > channel IDs defined in the dt-bindings/iio/qcom,spmi-vadc.h header
> > instead of specifying the numeric IDs.
> > 
> > Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>  
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

Applied to the togreg branch of iio.git

Thanks,

Jonathan
