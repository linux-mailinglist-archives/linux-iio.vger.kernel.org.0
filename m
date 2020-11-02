Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9552A2F78
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 17:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgKBQQX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 11:16:23 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:23760 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726771AbgKBQQX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 11:16:23 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A2G7c8M014044;
        Mon, 2 Nov 2020 17:16:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=jHb86NDYBn+RCxG2vcWk3aX1EGujfmsZTdv8PlRa3P0=;
 b=yj41yHskXH9oPrzMZfp4udVecos0BgNchmxlNk3H9TvA6GXApoVa9hqlXUxmk4FPvC0+
 +IVB301XsqfK9bGY6oTfqe80Cebsi1y/k6NHa/QupEIrMKhV/rtdp2//gWt2Df+nxhet
 /fKdcCMIRM48O/hgodXjPV5s5r+x98T+ZmtJglJz9qGEeTCqF6azDn0AaXeOq4AX0A96
 R9vSgpmCsqIsCab8rILpEX5XxfB7kNxVgPBzyqFaTs8voGSAZLlB1i38adKReAl0EvpE
 SZfDZaxlHRXzIUaV+EuKJZdO//UZqxgToV7u0Pn+LRSbHUBkWf53Tn1ZkUULNfXGNCbs 8w== 
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112])
        by mx07-00178001.pphosted.com with ESMTP id 34gyw132ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 17:16:05 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1qlbWdQg950OkYwHwCRhADd1540ieVXv5sagGsLsQyNEf13f1De1vLsIt1z4PgslDhja4rwOUhRfLL8eudprwXkkpze6eYGSb2ftNO1Wl3HDzevMTGzca/vmn2UbUt0i5ariP+EO8YbAg6k3ooUEf7/VR+ms7/Q9HjUmZH9CN3hLeAF2pajRN4UY0LzgN0+wQ0GY3DlwKW3cjmrR+hgIVsgvPy7xklXdYc+oOFCOzzUFmq2M0Cx8fQwpIZON0fBFyw00aE4FFFdHb9GL0L2EPBZeA8Ps7yRZq3yu1mnTESVBLaw5bDtzkkbVo3HwE2pXLf+O5qXCWmIYkQaBjiJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHb86NDYBn+RCxG2vcWk3aX1EGujfmsZTdv8PlRa3P0=;
 b=OlX0aDuZrDLD3g6DN5H0gMOIH8UHb0D9MagnV67xSsfOHVs4IQsDd9oNVQ7oa62FYFxipMi09oot47AmsBZDHkYmnys4O7BcuAkco5MkJBT2Xs1FM5RMlrEnwaTAQ3LltCB1KnUNQc3t0FMsswV3g8bXvux4+eATwhuxZ7tQhoMUqtwretBIwFS3JkpbXR5oGEmr3YBxbsyNF0ylbuqIsIQDv+nPf9uvYTMP364COXObell+4mOpjg5I1ct1diy/6uma8JZP41/RLg2uEHfQixGutOsAB3PskSUfHnWHqANUVFBCwZwyqx+gH+Abk9yOdmQPhvBUemhSofwq0dmNOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from AM8PR10MB4209.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1c8::21)
 by AM8PR10MB4113.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 16:16:04 +0000
Received: from AM8PR10MB4209.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c4bb:187f:c55a:8d09]) by AM8PR10MB4209.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c4bb:187f:c55a:8d09%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 16:16:04 +0000
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH 44/46] dt-bindings:iio:st,st-sensors: txt to yaml
 conversion.
Thread-Topic: [PATCH 44/46] dt-bindings:iio:st,st-sensors: txt to yaml
 conversion.
Thread-Index: AQHWr7cDBXBc3wuEvU+ePMDzV772Gqm1Bupg
Date:   Mon, 2 Nov 2020 16:16:04 +0000
Message-ID: <AM8PR10MB4209DBDB3270D3685507EE67ED100@AM8PR10MB4209.EURPRD10.PROD.OUTLOOK.COM>
References: <20201031184854.745828-1-jic23@kernel.org>
 <20201031184854.745828-45-jic23@kernel.org>
In-Reply-To: <20201031184854.745828-45-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=st.com;
x-originating-ip: [165.225.34.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1c96f91-f211-473e-1aa9-08d87f4a98e3
x-ms-traffictypediagnostic: AM8PR10MB4113:
x-microsoft-antispam-prvs: <AM8PR10MB41139E6E6FCB659215A1C90BED100@AM8PR10MB4113.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: enAwnPxRumDyO/y+16eIqFdinrsDMMDJ0exkqLOG0BVzjjtbgXB0Yo6eEEcCaY66XiFl48auL2WLtzKNhX2WQEVRmarRsxZbAP2BkyCAjsfEjT2n+qSwd4D3HjnrtY4Q4GbOM4US07dLfCEmHhPe21cdmj0gaR4BTm16WGGMrYMUMsq9PM7r6UZ6w4XtUupL2Mnx+bFi+hZqS6aMgYvdEoboLpemklqzn6VGQ21ZfTSd0YcuCnry9W3svg2hL7y9iVJm04LaNKXStAtxxI2oKze2YImAk95eyuQbqBAE0pvggPrJrCKtti4Ine7ctX3bZStx5JV6rCCWyzOxLzMk3nUhGBctJrXo3llEEGZQ5B9phaYdZatu1V8N32QTThD2vFhVYKJ8xpdWVw96mN+UaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4209.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(55236004)(6506007)(53546011)(966005)(5660300002)(9686003)(71200400001)(66946007)(64756008)(66476007)(52536014)(66446008)(66556008)(76116006)(8936002)(33656002)(26005)(86362001)(316002)(83380400001)(8676002)(186003)(2906002)(4326008)(7696005)(55016002)(110136005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: y+G5RTDEafsC/wrXmSjpPBzTahkz/qyvyB4vb7QbGN6yBEBJdg+78wcbKn7EDDKUaw7W+zNVKHjivGraqqG1EivkIpoZZHFCw1aX1gsqYA4qCmTdGWeiekwh6ckAncT68SV748nly5AwW/3DH+0ixJNk4ZkXs6MrCxxtKkyNa5SMbM2ue52xjX7W4iSNgaafTiaNh2yJ1lDxWyX9RQCXWOLdwTTJLHVLrhQ72Lb1w7HBg6VcIHJ/ZXSsRVQoMzICx36YR08ut4jmL4vVXiBtvsGStmPol0aAZpxC8qJQZuenWidLaFEl4skPSyLMIgEVRJ3PGy+iLScnBO3nP5F1GkOdyN5gDpqY0a/7Si+tLW1qlFHWQDalgjHMFlZ2G1iUCfjSXkKZIypQ8tPqGstoSTRAilk2m03Xk9fjN/xgaeLv8k7c94y43fkDA2V0cy1kY1OyGmAsNBQwJ5RZF2HjiYohlnP2zUH60MG90tCgPzh5iVsrA1c1Sgyuq9fnhRI36VrzJZrSbpWLJyfQ+Cbq6l35BqiRRs/7Cqz8HN1C7XZ4GAtxkMFWzKEyBBItzbOF1Ar6oUDORjKMbTSbimkzMhyFUzAqAJXWyA960jtzGqoyloAOO7bNUZz3JThnUt9xFKgzIiUp7KcSVlmIfLnQPA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4209.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c96f91-f211-473e-1aa9-08d87f4a98e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 16:16:04.1376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPIMPDt4FQzNa95K8HQV1qYp2I7vxxkorV1Pa2rGXD7WhWsEFZa7HRPNKJg6G+8B89Tf/RNbyLjiRH6SkYYxCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4113
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-02_09:2020-11-02,2020-11-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 spamscore=0 phishscore=0 adultscore=0 clxscore=1011 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011020125
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

Yes it is good to me. Thanks for doing this, much appreciated.

Acked-by: Denis Ciocca <denis.ciocca@st.com>

Thanks,
Denis

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, October 31, 2020 11:49 AM
> To: linux-iio@vger.kernel.org; Rob Herring <robh+dt@kernel.org>;
> devicetree@vger.kernel.org
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Denis CIOCCA
> <denis.ciocca@st.com>
> Subject: [PATCH 44/46] dt-bindings:iio:st,st-sensors: txt to yaml convers=
ion.
>=20
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This binding document covers a very large number of different sensors.
> As such the existing documentation is less specific than it could be (suc=
h as
> which devices have 2 interrupt pin options).
> That can be improved later.
>=20
> Denis, are you happy to be listed as maintainer for this one?
> If not feel free to suggestion someone else.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> ---
>  .../bindings/iio/st,st-sensors.yaml           | 123 ++++++++++++++++++
>  .../devicetree/bindings/iio/st-sensors.txt    |  82 ------------
>  2 files changed, 123 insertions(+), 82 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> new file mode 100644
> index 000000000000..db291a9390b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/st,st-sensors.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics MEMS sensors
> +
> +description: |
> +  Note that whilst this covers many STMicro MEMs sensors, some more
> +complex
> +  IMUs need their own bindings.
> +  The STMicroelectronics sensor devices are pretty straight-forward I2C
> +or
> +  SPI devices, all sharing the same device tree descriptions no matter
> +what
> +  type of sensor it is.
> +
> +maintainers:
> +  - Denis Ciocca <denis.ciocca@st.com>
> +
> +properties:
> +  compatible:
> +    description: |
> +      Some values are deprecated.
> +      st,lis3lv02d (deprecated, use st,lis3lv02dl-accel)
> +      st,lis302dl-spi (deprecated, use st,lis3lv02dl-accel)
> +    enum:
> +        # Accelerometers
> +      - st,lis3lv02d
> +      - st,lis302dl-spi
> +      - st,lis3lv02dl-accel
> +      - st,lsm303dlh-accel
> +      - st,lsm303dlhc-accel
> +      - st,lis3dh-accel
> +      - st,lsm330d-accel
> +      - st,lsm330dl-accel
> +      - st,lsm330dlc-accel
> +      - st,lis331dl-accel
> +      - st,lis331dlh-accel
> +      - st,lsm303dl-accel
> +      - st,lsm303dlm-accel
> +      - st,lsm330-accel
> +      - st,lsm303agr-accel
> +      - st,lis2dh12-accel
> +      - st,h3lis331dl-accel
> +      - st,lng2dm-accel
> +      - st,lis3l02dq
> +      - st,lis2dw12
> +      - st,lis3dhh
> +      - st,lis3de
> +      - st,lis2de12
> +      - st,lis2hh12
> +        # Gyroscopes
> +      - st,l3g4200d-gyro
> +      - st,lsm330d-gyro
> +      - st,lsm330dl-gyro
> +      - st,lsm330dlc-gyro
> +      - st,l3gd20-gyro
> +      - st,l3gd20h-gyro
> +      - st,l3g4is-gyro
> +      - st,lsm330-gyro
> +      - st,lsm9ds0-gyro
> +        # Magnetometers
> +      - st,lsm303agr-magn
> +      - st,lsm303dlh-magn
> +      - st,lsm303dlhc-magn
> +      - st,lsm303dlm-magn
> +      - st,lis3mdl-magn
> +      - st,lis2mdl
> +      - st,lsm9ds1-magn
> +        # Pressure sensors
> +      - st,lps001wp-press
> +      - st,lps25h-press
> +      - st,lps331ap-press
> +      - st,lps22hb-press
> +      - st,lps33hw
> +      - st,lps35hw
> +      - st,lps22hh
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +
> +  vdd-supply: true
> +  vddio-supply: true
> +
> +  st,drdy-int-pin:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Some sensors have multiple possible pins via which they can provid=
e
> +      a data ready interrupt.  This selects which one.
> +    enum:
> +      - 1
> +      - 2
> +
> +  drive-open-drain:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      The interrupt/data ready line will be configured as open drain, wh=
ich
> +      is useful if several sensors share the same interrupt line.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        accelerometer@1d {
> +            compatible =3D "st,lis3lv02dl-accel";
> +            reg =3D <0x1d>;
> +            interrupt-parent =3D <&gpio2>;
> +            interrupts =3D <18 IRQ_TYPE_EDGE_RISING>;
> +            pinctrl-0 =3D <&lis3lv02dl_nhk_mode>;
> +            pinctrl-names =3D "default";
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt
> b/Documentation/devicetree/bindings/iio/st-sensors.txt
> deleted file mode 100644
> index 3213599c5071..000000000000
> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> +++ /dev/null
> @@ -1,82 +0,0 @@
> -STMicroelectronics MEMS sensors
> -
> -The STMicroelectronics sensor devices are pretty straight-forward I2C or=
 -
> SPI devices, all sharing the same device tree descriptions no matter what=
 -
> type of sensor it is.
> -
> -Required properties:
> -- compatible: see the list of valid compatible strings below
> -- reg: the I2C or SPI address the device will respond to
> -
> -Optional properties:
> -- vdd-supply: an optional regulator that needs to be on to provide VDD
> -  power to the sensor.
> -- vddio-supply: an optional regulator that needs to be on to provide the
> -  VDD IO power to the sensor.
> -- st,drdy-int-pin: the pin on the package that will be used to signal
> -  "data ready" (valid values: 1 or 2). This property is not configurable
> -  on all sensors.
> -- drive-open-drain: the interrupt/data ready line will be configured
> -  as open drain, which is useful if several sensors share the same
> -  interrupt line. (This binding is taken from pinctrl/pinctrl-bindings.t=
xt)
> -  This is a boolean property.
> -
> -Sensors may also have applicable pin control settings, those use the -
> standard bindings from pinctrl/pinctrl-bindings.txt.
> -
> -Valid compatible strings:
> -
> -Accelerometers:
> -- st,lis3lv02d (deprecated, use st,lis3lv02dl-accel)
> -- st,lis302dl-spi (deprecated, use st,lis3lv02dl-accel)
> -- st,lis3lv02dl-accel
> -- st,lsm303dlh-accel
> -- st,lsm303dlhc-accel
> -- st,lis3dh-accel
> -- st,lsm330d-accel
> -- st,lsm330dl-accel
> -- st,lsm330dlc-accel
> -- st,lis331dl-accel
> -- st,lis331dlh-accel
> -- st,lsm303dl-accel
> -- st,lsm303dlm-accel
> -- st,lsm330-accel
> -- st,lsm303agr-accel
> -- st,lis2dh12-accel
> -- st,h3lis331dl-accel
> -- st,lng2dm-accel
> -- st,lis3l02dq
> -- st,lis2dw12
> -- st,lis3dhh
> -- st,lis3de
> -- st,lis2de12
> -- st,lis2hh12
> -
> -Gyroscopes:
> -- st,l3g4200d-gyro
> -- st,lsm330d-gyro
> -- st,lsm330dl-gyro
> -- st,lsm330dlc-gyro
> -- st,l3gd20-gyro
> -- st,l3gd20h-gyro
> -- st,l3g4is-gyro
> -- st,lsm330-gyro
> -- st,lsm9ds0-gyro
> -
> -Magnetometers:
> -- st,lsm303agr-magn
> -- st,lsm303dlh-magn
> -- st,lsm303dlhc-magn
> -- st,lsm303dlm-magn
> -- st,lis3mdl-magn
> -- st,lis2mdl
> -- st,lsm9ds1-magn
> -
> -Pressure sensors:
> -- st,lps001wp-press
> -- st,lps25h-press
> -- st,lps331ap-press
> -- st,lps22hb-press
> -- st,lps33hw
> -- st,lps35hw
> -- st,lps22hh
> --
> 2.28.0

