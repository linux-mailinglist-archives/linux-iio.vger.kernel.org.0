Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6E8626A4B
	for <lists+linux-iio@lfdr.de>; Sat, 12 Nov 2022 16:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiKLPlJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Nov 2022 10:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiKLPlI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2022 10:41:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7441AF1C;
        Sat, 12 Nov 2022 07:41:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37B60B80943;
        Sat, 12 Nov 2022 15:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7875CC433D6;
        Sat, 12 Nov 2022 15:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668267664;
        bh=dLq9YD8fzmn23nYLtg+yfmTIkefkqgbfgx6wWA1+cdU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LjC7pYkcm5BAtgGj7t8cUS21lTCoXOmE+YakYS54NvFzsL4B5QBfSVfms53LQ8mTI
         iC7PGNBApxCR2p9/65pka8Rnd+gM4lPM33a2hPj/F7ld9bqEmOdLAqyqYoa99Q+qHf
         Wo9UhCDUG+ltp+lYbVcOwAFMqSAS2+/1vLHHGKu0FKiMTPN6lJGlA9glY3XTzBDxVP
         Cv+AJw6Ot4b2P7RZIiKkoWmnWZX5tC84frmEYBpe/nKJ+3kWDubMFf/2Ee0W2DEU7f
         V12rBVGaW2mUj8zAZrHAAFb618iT03bbtL0BjbPPaeIzPJd+4WO2/c+VVuE2eZ9uc9
         v5ozv40doTM+A==
Date:   Sat, 12 Nov 2022 15:53:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsv16x
 device bindings
Message-ID: <20221112155318.01bd737f@jic23-huawei>
In-Reply-To: <Y2pm5HpHu+O1cl4n@localhost.localdomain>
References: <cover.1667745215.git.lorenzo@kernel.org>
        <8d10a63ec6abd22863ab25addd8c2f578dbc9cd9.1667745215.git.lorenzo@kernel.org>
        <a464ae19-3b18-3a34-9706-151b1512057b@linaro.org>
        <Y2pm5HpHu+O1cl4n@localhost.localdomain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Nov 2022 15:25:40 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > On 06/11/2022 15:36, Lorenzo Bianconi wrote:  
> > > Add device bindings for lsm6dsv16x IMU sensor.  
> > 
> > Drop redundant, second "device bindings" in subject.  So the subject
> > should be (also with different prefix):  
> 
> ack
> 
> > 
> > dt-bindings: iio: imu:: st,lsm6dsx.yaml: add lsm6dsv16x
> > 
> > With subject fixes:
> > 
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > Best regards,
> > Krzysztof
> >   
> 
> @Jonathan: do you want me send v2 or are you going to take care of it?
> 
> Regards,
> Lorenzo

I tidied the patch title up whilst applying. Applied to the togreg
branch of iio.git and pushed out as testing for all the normal reasons.

Thanks,

Jonathan
