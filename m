Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0953378EB32
	for <lists+linux-iio@lfdr.de>; Thu, 31 Aug 2023 12:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbjHaK6u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Aug 2023 06:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbjHaK6u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 31 Aug 2023 06:58:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A751CF3
        for <linux-iio@vger.kernel.org>; Thu, 31 Aug 2023 03:58:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so824605a12.2
        for <linux-iio@vger.kernel.org>; Thu, 31 Aug 2023 03:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693479526; x=1694084326; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ANiV6pVTHe22vduWsQCzD7/kNMTm2rXNTRfhsAcavXw=;
        b=Jpm2plUTMdyPkyJ/QO+vEElj+xomqa1UdjSdQ75nVvtOvcQETd2DEOz3GMVD9/8o5F
         sQMYKk9WzMokFy5q9/FTaIV+hc7nsJy6mjaiM4e3qA0sa0BTP0aCqIKKhA98/2tGPBH4
         7ISyZRtnAVznYvuyYXg2X4mFTpJ13NrP2oIhGwzhANfBDbMn1qRflpSHA9LSSDc3XVPO
         T7islZ6BBZWus0CwzfOqv0rihUyN5XaPHj5DBoVgLzWQi8nwYXBsA/x/8hev3p+ynaCb
         kv5RmXzuWJVwhJoHv5KFOtDuV0Z4DASTB3XAvaqdY6COuCKU//AXYbHpUYykwt7+xB1Y
         MVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693479526; x=1694084326;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ANiV6pVTHe22vduWsQCzD7/kNMTm2rXNTRfhsAcavXw=;
        b=I/x2V+mRKjNhk/WNuoE31JJ3TG0v2vqllT9XoZddgkZbHSeiFUX+4/je+YEHG48enr
         Ss+FIphbJKXpkjLB83ouiIpdJRhnoqOVSlkGFkImnR1jbFOX5Nn0jIG5AWfVJ8XdzvQC
         7Yu2nC2g1WLBOihpHSIn8+ANeeEaABC9fx/wT3ez0l1sHQldDtb6O57kzmj5/3fsmQL8
         9ffNjDXWHm3J7T8KTKA6UHptR/CjYdgjVxiRd3WUk5eBvsbihSS5x4j1YV0NRrfQO7YH
         HfYaYksdMYBHX0tUG6Kv1WJqkls1OC2bVMgRBxqNgm1sqKr8UTg08kqEaocMDNTpBu0f
         ZixQ==
X-Gm-Message-State: AOJu0Yzu5310gvyCp6w2NtyeJ6X23DwyGLKg5uPcle93w1Vz4pVnAnB9
        rT3hGQIPb9NvkvEFseWGEwI=
X-Google-Smtp-Source: AGHT+IGLHqCPXKCwWbnFJQX0s7PW1unCVBSzFWIFO0HMJ4xQwDt0enFEi7TKnOFL1aunrEBj+d/pRA==
X-Received: by 2002:a05:6402:2c4:b0:523:38f5:c5ad with SMTP id b4-20020a05640202c400b0052338f5c5admr3620802edx.20.1693479525589;
        Thu, 31 Aug 2023 03:58:45 -0700 (PDT)
Received: from ?IPv6:2001:a61:3488:8a01:c631:bde5:1eff:9b66? ([2001:a61:3488:8a01:c631:bde5:1eff:9b66])
        by smtp.gmail.com with ESMTPSA id h3-20020a50ed83000000b005236b47116asm648098edr.70.2023.08.31.03.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 03:58:45 -0700 (PDT)
Message-ID: <5cb434575554ae2cfaadc4ec02e118112e74a898.camel@gmail.com>
Subject: Re: [RFC PATCH 0/3] Add converter framework
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Date:   Thu, 31 Aug 2023 12:58:44 +0200
In-Reply-To: <20230831102806.000026cd@Huawei.com>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
         <20230830172903.0000027f@Huawei.com>
         <d4eead3eedb99e252f7c022ce5572a3a307b9b1e.camel@gmail.com>
         <20230831102806.000026cd@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2023-08-31 at 10:28 +0100, Jonathan Cameron wrote:
> On Thu, 31 Aug 2023 10:20:20 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Wed, 2023-08-30 at 17:29 +0100, Jonathan Cameron wrote:
> > > On Fri, 4 Aug 2023 16:53:38 +0200
> > > Nuno Sa <nuno.sa@analog.com> wrote:
> > > =C2=A0=20
> > > > This is the initial RFC following the discussion in [1]. I'm aware =
this is
> > > > by no means ready for inclusion and it's not even compilable since =
in
> > > > the RFC I did not included the patch to add component_compare_fwnod=
e()
> > > > and component_release_fwnode().=C2=A0=C2=A0=20
> > >=20
> > > Whilst I haven't read this through yet, I suspect Olivier will be abl=
e to
> > > offer some insight on some of this and likewise you may be able to
> > > point out pitfalls etc in his series (I see you did some review alrea=
dy :)
> > >=20
> > > https://lore.kernel.org/linux-iio/20230727150324.1157933-1-olivier.mo=
ysan@foss.st.com/
> > >=20
> > > Both are about multiple interacting components of an overall datapath=
.
> > > Whether there is commonality isn't yet clear to me.
> > > =C2=A0=20
> >=20
> > I made a very general comment in that series but I need to look better =
at it. Not
> > sure if we can merge them together but let's see...
>=20
> Great. I wasn't sure either!=C2=A0 If nothing else more cross review is a=
lways
> good even if we decide we need two frameworks.
>=20

Indeed...

> My one takeaway from looking at this is I need to understand the componen=
t
> framework better and do some messing around with simple cases before I'll

Fair enough... It's a fairly straight framework and I like the idea of havi=
ng the
whole thing (multiple devices) coming up/down together since it simplifies =
some
things. But I don't feel to strong about it so in the end, if we decide to =
go with
typical OF/FW lookup, also fine with me.

> be confident on how this works.=C2=A0 Maybe we can get some input from de=
velopers
> of that framework on future versions?
>=20

Sure, they might have some thoughts on the hacks I'm doing to use devres. B=
ut I fear
they'll be a bit biased for what they "enforce" in the component framework =
(my idea
was to build on top of it).

- Nuno S=C3=A1


