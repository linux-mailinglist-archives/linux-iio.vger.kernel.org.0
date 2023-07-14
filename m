Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3C47544C8
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jul 2023 00:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjGNWCL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jul 2023 18:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGNWCK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jul 2023 18:02:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E0B1BC9
        for <linux-iio@vger.kernel.org>; Fri, 14 Jul 2023 15:02:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666e3b15370so1844362b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 14 Jul 2023 15:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689372129; x=1691964129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B3DZ3QodLkTjKM8tLx8t86MoU1m0TSwGIA4Lmr1eciw=;
        b=xO0lJMv5ZVBnZmrsoKXYHg+5jX2CO6Anylt5EKGGHaPYsJyD2naV+Einq1HkpCbDEd
         70g3nFQQ/zzIUxit73R0+RWL+bRmq2+ip05QObmumBglucmYVvdzTpLteGwAbhKjoq2b
         YM6y7rH7FaDGcK4LloKDQHGr7mnuu+MWuAj/yt50MH2uvmPMHONXXCWiB7SkMzHWuHhc
         pZa/D0c3BSbMEde+jqms0oOT04fw9S8YbwAdQDmsvvaAUTiC/aLViiREOs8Ud8kkmyRu
         Ov5ek9e56Lx9wWpZVgKFDBXGRgOIHepnFTjp9MqaotCy6mue0pws3PGWTFKzQca6squv
         iD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689372129; x=1691964129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3DZ3QodLkTjKM8tLx8t86MoU1m0TSwGIA4Lmr1eciw=;
        b=dPClrg0EOVx6sml8xkZzKE6vADu+zvlcRMqC+tW5I9ZqvsOgEAY8oBRWKNV3wflL/a
         BXBlNTpU9t92xq6l3UVU94vzlUfwUOmIztNLkcxfPTy4gJYDeHr91Zc33a3S/45wzSPR
         DrwW/UCYepuV2EYfOpAPujDn8Lq0mSAFXX6bM8R3mpsgIS+XRWZFq4CJaPUt9u07unOr
         d06TG7creEvrD7v58zx57M10nuovJs4aRj2/B6r1Ic2zSIM1EO+LR3t8FAEWZ+iUYMsi
         tJ64MpPi6qHwrfXclogPvdQ9xtFUTiJH3xci/q87bsmvEgau8R9n3YRwAssIyJc1wKBP
         oJag==
X-Gm-Message-State: ABy/qLYBwOB13ZyoLXqpNe9qVIuGlI2Kra4d+8VH6tUrB1TyjTwD9DgJ
        grfc0pulIkpnR7l4Na0D6jT3BA==
X-Google-Smtp-Source: APBJJlEPhk3QAeLODRppoEJ8Y7tCUc2xqclRZUChAEpPHOArrhf5SttTvbB0tk/lqEdMIxDEWm45Bw==
X-Received: by 2002:a05:6a00:cc5:b0:668:846b:9b5d with SMTP id b5-20020a056a000cc500b00668846b9b5dmr7234962pfv.5.1689372129136;
        Fri, 14 Jul 2023 15:02:09 -0700 (PDT)
Received: from fedora (61-114-134-192.ppp.bbiq.jp. [61.114.134.192])
        by smtp.gmail.com with ESMTPSA id a12-20020aa7864c000000b00666e649ca46sm7608915pfo.101.2023.07.14.15.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 15:02:08 -0700 (PDT)
Date:   Fri, 14 Jul 2023 07:34:03 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Anh Tuan Phan <tuananhlfc@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org, rongtao@cestc.cn,
        ricardo@pardini.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/counter: Add checking directory exists for make
 clean
Message-ID: <ZLEyq1Nx085jlxDr@fedora>
References: <362e127d-6018-5fc6-247b-3c729b99d946@gmail.com>
 <ZKtZ1WB9LdszbxU+@fedora>
 <e62f481d-f939-a12b-7f8a-ec1db95c7b8e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kbfYM6KMOcOKmno2"
Content-Disposition: inline
In-Reply-To: <e62f481d-f939-a12b-7f8a-ec1db95c7b8e@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--kbfYM6KMOcOKmno2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 14, 2023 at 08:57:21PM +0700, Anh Tuan Phan wrote:
> Hi William, the race condition possibility is a good point. Thanks for
> suggesting me. Will send a new version with using `rm -df` instead and
> add the appropriate CC lists. Thank you!

Hi Anh,

Because this will fix a failure, please include a Fixes tag as well that
references the commit that introduces the rmdir line.

Thanks,

William Breathitt Gray

--kbfYM6KMOcOKmno2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZLEyqwAKCRC1SFbKvhIj
K+ziAQCGY7jdv3OM3sbn+dCb3FZsFSrqndT/N7q7OXZdDBiEwwD9GrllxnmAAjJU
2pmDiD0aeGvLOlLxjxi7SHSWcRRAZQs=
=CrFK
-----END PGP SIGNATURE-----

--kbfYM6KMOcOKmno2--
