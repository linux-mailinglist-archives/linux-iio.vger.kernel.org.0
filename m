Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF48C621676
	for <lists+linux-iio@lfdr.de>; Tue,  8 Nov 2022 15:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiKHO1d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Nov 2022 09:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiKHO0z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Nov 2022 09:26:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB6654B21;
        Tue,  8 Nov 2022 06:25:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2B5BB81ADB;
        Tue,  8 Nov 2022 14:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DED6C433C1;
        Tue,  8 Nov 2022 14:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667917544;
        bh=h+OS/eZgJV0ZrEr+BmOb2Klmpo3eKv9LYWIpJROuFGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RHcUzAeQY1Qwi5CovXPIcX3MfxTd7xPUidAtjdD8jYyOrgusaZ6+EhH76mxf6wpKD
         pGhXPpk6Tm9nU10yR5gv27xqD5LdnRkoH7U1xGpoUeCIwLId1QcrIF45sZoi1xc5oc
         1WTvKZ2hZv0kpMdA+zxwNTUpPafgf8N8Vpyahct42uow1fsYuIgbOVdk7j/gTkB8lG
         qOMRX+k2a/JhQtPKLqFkFrmFk8g1IiV0fixJ/irlifzkjdzwsV3C3vVMwnHwNZ09c+
         bEZzqSbPWgAozKi5IfDWnti98NozxlQPr0JRlcachFjnbXx4PznTfHXYFONl2NbmsJ
         eQQE1dhsAltcw==
Date:   Tue, 8 Nov 2022 15:25:40 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.bianconi@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsv16x
 device bindings
Message-ID: <Y2pm5HpHu+O1cl4n@localhost.localdomain>
References: <cover.1667745215.git.lorenzo@kernel.org>
 <8d10a63ec6abd22863ab25addd8c2f578dbc9cd9.1667745215.git.lorenzo@kernel.org>
 <a464ae19-3b18-3a34-9706-151b1512057b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wTnk1G2BRa0HT9Ms"
Content-Disposition: inline
In-Reply-To: <a464ae19-3b18-3a34-9706-151b1512057b@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--wTnk1G2BRa0HT9Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 06/11/2022 15:36, Lorenzo Bianconi wrote:
> > Add device bindings for lsm6dsv16x IMU sensor.
>=20
> Drop redundant, second "device bindings" in subject.  So the subject
> should be (also with different prefix):

ack

>=20
> dt-bindings: iio: imu:: st,lsm6dsx.yaml: add lsm6dsv16x
>=20
> With subject fixes:
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> Best regards,
> Krzysztof
>=20

@Jonathan: do you want me send v2 or are you going to take care of it?

Regards,
Lorenzo

--wTnk1G2BRa0HT9Ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY2pm4QAKCRA6cBh0uS2t
rE2vAP9BE6X9wPoL+D+iHzKiPQ1cakg+w07uzTgSIT+3k/eriAD6AsdaLY8NEAsf
ZlSKLVLQPO6rI87pdP8w0DLe6vzLLwo=
=Uv2j
-----END PGP SIGNATURE-----

--wTnk1G2BRa0HT9Ms--
